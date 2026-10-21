import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:printing/printing.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/upload_guard.dart';
import '../data/case_store.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';

enum CaptureSource { camera, files }

const _limits = UploadLimits();

class _Page {
  _Page({
    required this.page,
    required this.pageCount,
    this.thumb,
    this.fromCamera = false,
  });

  PreparedPage page;
  final int pageCount;
  Uint8List? thumb;
  final bool fromCamera;
}

/// Take photos or pick a PDF/images, put the pages in order, then upload.
/// Pops with the case id once the pages are stored.
class CaptureScreen extends StatefulWidget {
  const CaptureScreen({
    super.key,
    required this.store,
    required this.source,
    this.replaceCaseId,
  });

  final CaseStore store;
  final CaptureSource source;

  /// Upload a new page set for this case instead of creating one.
  final String? replaceCaseId;

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  final _pages = <_Page>[];
  bool _busy = false;
  bool _uploading = false;
  String? _message;
  bool _cameraFailed = false;

  int get _totalPages => _pages.fold(0, (s, p) => s + p.pageCount);
  int get _totalBytes => _pages.fold(0, (s, p) => s + p.page.bytes.length);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.source == CaptureSource.camera) {
        _camera();
      } else {
        _files();
      }
    });
  }

  String _rejectText(AppLocalizations l, UploadReject r) => switch (r) {
    UploadReject.empty => l.cnUpEmpty,
    UploadReject.tooLarge => l.cnUpTooLarge(
      _limits.maxFileBytes ~/ (1024 * 1024),
    ),
    UploadReject.caseTooLarge => l.cnUpCaseTooLarge(
      _limits.maxCaseBytes ~/ (1024 * 1024),
    ),
    UploadReject.tooManyPages => l.cnUpTooManyPages(_limits.maxPages),
    UploadReject.unsupported => l.cnUpUnsupported,
    UploadReject.badSignature => l.cnUpBadFile,
    UploadReject.encryptedPdf => l.cnUpEncrypted,
  };

  /// Checks one file and adds it (or replaces [replace]). Returns an error text.
  Future<String?> _add(
    Uint8List bytes,
    String mime,
    String name, {
    bool fromCamera = false,
    int? replace,
  }) async {
    final l = AppLocalizations.of(context)!;
    final others = [
      for (var i = 0; i < _pages.length; i++)
        if (i != replace) _pages[i],
    ];
    final check = inspectUpload(
      bytes: bytes,
      mime: mime,
      existingCaseBytes: others.fold(0, (s, p) => s + p.page.bytes.length),
      existingPages: others.fold(0, (s, p) => s + p.pageCount),
      limits: _limits,
    );
    if (!check.accepted) return _rejectText(l, check.reject!);

    var data = bytes;
    var type = mime;
    var count = 1;
    Uint8List? thumb;
    if (mime == 'application/pdf') {
      try {
        count = 0;
        await for (final r in Printing.raster(bytes, dpi: 30)) {
          count++;
          thumb ??= await r.toPng();
          if (count > _limits.maxPages) break;
        }
      } catch (_) {
        return l.cnUpBadFile;
      }
      if (count == 0) return l.cnUpBadFile;
      final existing = others.fold(0, (s, p) => s + p.pageCount);
      if (existing + count > _limits.maxPages) {
        return l.cnUpTooManyPages(_limits.maxPages);
      }
    } else {
      final upright = await compute(_uprightJpeg, bytes);
      if (upright != null) {
        data = upright;
        type = 'image/jpeg';
      }
      thumb = data;
    }
    final page = _Page(
      page: PreparedPage(bytes: data, mime: type, name: name, pageCount: count),
      pageCount: count,
      thumb: thumb,
      fromCamera: fromCamera,
    );
    setState(() {
      if (replace != null) {
        _pages[replace] = page;
      } else {
        _pages.add(page);
      }
    });
    return null;
  }

  Future<void> _camera({int? replace}) async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final x = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 2400,
        maxHeight: 2400,
        imageQuality: 88,
      );
      if (x == null) return;
      final bytes = await x.readAsBytes();
      final mime = _sniffImageMime(bytes) ?? (x.mimeType ?? 'image/jpeg');
      final err = await _add(
        bytes,
        mime,
        x.name,
        fromCamera: true,
        replace: replace,
      );
      if (mounted) setState(() => _message = err);
    } on PlatformException {
      if (mounted) {
        setState(() {
          _cameraFailed = true;
          _message = l.cnCameraUnavailable;
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _gallery() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final x = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 2400,
        maxHeight: 2400,
        imageQuality: 88,
      );
      if (x == null) return;
      final bytes = await x.readAsBytes();
      final mime =
          _sniffImageMime(bytes) ?? (x.mimeType ?? 'application/octet-stream');
      final err = await _add(bytes, mime, x.name);
      if (mounted) setState(() => _message = err);
    } on PlatformException {
      if (mounted) setState(() => _message = l.cnPhotosUnavailable);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _files() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final picked = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
      );
      String? err;
      for (final f in picked) {
        final size = f.lengthSync() ?? await f.length();
        if (size != null && size > _limits.maxFileBytes) {
          err = l.cnUpTooLarge(_limits.maxFileBytes ~/ (1024 * 1024));
          continue;
        }
        final bytes = await f.readAsBytes();
        final mime =
            _sniffImageMime(bytes) ??
            (_isPdf(bytes) ? 'application/pdf' : _mimeFromName(f.name));
        err = await _add(bytes, mime, f.name) ?? err;
      }
      if (mounted) setState(() => _message = err);
    } on PlatformException {
      if (mounted) setState(() => _message = l.cnFilesUnavailable);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _rotate(int i) async {
    final p = _pages[i];
    if (!p.page.isImage) return;
    setState(() => _busy = true);
    final out = await compute(_rotateJpeg, p.page.bytes);
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (out != null) {
        p.page = PreparedPage(
          bytes: out,
          mime: 'image/jpeg',
          name: p.page.name,
          pageCount: 1,
        );
        p.thumb = out;
      }
    });
  }

  Future<void> _upload() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _uploading = true;
      _message = null;
    });
    try {
      final pages = [for (final p in _pages) p.page];
      final String caseId;
      if (widget.replaceCaseId != null) {
        await widget.store.replacePages(widget.replaceCaseId!, pages);
        caseId = widget.replaceCaseId!;
      } else {
        caseId = await widget.store.createFromPages(pages);
      }
      if (mounted) Navigator.pop(context, caseId);
    } on CaseStoreException catch (e) {
      if (mounted) setState(() => _message = caseErrorText(l, e.code));
    } catch (_) {
      if (mounted) setState(() => _message = l.cnUploadFailed);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  void _preview(_Page p) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(p.page.name)),
          body: p.page.isImage
              ? InteractiveViewer(
                  maxScale: 5,
                  child: Center(child: Image.memory(p.page.bytes)),
                )
              : PdfPreview(
                  build: (_) async => p.page.bytes,
                  useActions: false,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  canDebug: false,
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final replacing = widget.replaceCaseId != null;
    return PopScope(
      canPop: !_uploading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(replacing ? l.cnReplacePagesTitle : l.cnCaptureTitle),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _pages.isEmpty
                    ? SingleChildScrollView(
                        child: ActionMessage(
                          icon: Icons.document_scanner_outlined,
                          title: _busy ? l.cnOpening : l.cnCaptureEmptyTitle,
                          body: l.cnCaptureTips,
                        ),
                      )
                    : ReorderableListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        itemCount: _pages.length,
                        buildDefaultDragHandles: false,
                        onReorderItem: (from, to) => setState(
                          () => _pages.insert(to, _pages.removeAt(from)),
                        ),
                        itemBuilder: (_, i) => _PageTile(
                          key: ObjectKey(_pages[i]),
                          index: i,
                          page: _pages[i],
                          enabled: !_busy && !_uploading,
                          onPreview: () => _preview(_pages[i]),
                          onRotate: _pages[i].page.isImage
                              ? () => _rotate(i)
                              : null,
                          onRetake: _pages[i].fromCamera
                              ? () => _camera(replace: i)
                              : null,
                          onDelete: () => setState(() => _pages.removeAt(i)),
                        ),
                      ),
              ),
              if (_message != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: CnColors.warn),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _message!,
                          style: const TextStyle(color: CnColors.warn),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  children: [
                    if (!_cameraFailed)
                      OutlinedButton.icon(
                        onPressed: _busy || _uploading ? null : () => _camera(),
                        icon: const Icon(Icons.photo_camera_outlined),
                        label: Text(
                          _pages.isEmpty ? l.cnTakePhoto : l.cnAddPage,
                        ),
                      ),
                    OutlinedButton.icon(
                      onPressed: _busy || _uploading ? null : _gallery,
                      icon: const Icon(Icons.photo_library_outlined),
                      label: Text(l.cnAddPhoto),
                    ),
                    OutlinedButton.icon(
                      onPressed: _busy || _uploading ? null : _files,
                      icon: const Icon(Icons.picture_as_pdf_outlined),
                      label: Text(l.cnAddPdf),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_pages.isNotEmpty)
                      Text(
                        l.cnPagesSummary(
                          _totalPages,
                          (_totalBytes / (1024 * 1024)).toStringAsFixed(1),
                        ),
                        style: const TextStyle(
                          color: CnColors.muted,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      l.cnUploadConsent,
                      style: const TextStyle(
                        color: CnColors.muted,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: _pages.isEmpty || _busy || _uploading
                            ? null
                            : _upload,
                        icon: _uploading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.cloud_upload_outlined),
                        label: Text(
                          _uploading ? l.cnStageUploading : l.cnUploadAndRead,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageTile extends StatelessWidget {
  const _PageTile({
    super.key,
    required this.index,
    required this.page,
    required this.enabled,
    required this.onPreview,
    required this.onDelete,
    this.onRotate,
    this.onRetake,
  });

  final int index;
  final _Page page;
  final bool enabled;
  final VoidCallback onPreview;
  final VoidCallback onDelete;
  final VoidCallback? onRotate;
  final VoidCallback? onRetake;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final label = page.page.isImage
        ? l.cnPageN(index + 1)
        : l.cnPdfPages(index + 1, page.pageCount);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CnCard(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            InkWell(
              onTap: onPreview,
              child: Semantics(
                label: l.cnPreviewPage(index + 1),
                button: true,
                child: Container(
                  width: 64,
                  height: 84,
                  color: const Color(0xFFF1F4F7),
                  child: page.thumb == null
                      ? const Icon(Icons.picture_as_pdf_outlined)
                      : Image.memory(
                          page.thumb!,
                          fit: BoxFit.cover,
                          cacheWidth: 160,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    page.page.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: CnColors.muted, fontSize: 13),
                  ),
                  Wrap(
                    children: [
                      if (onRotate != null)
                        IconButton(
                          tooltip: l.cnRotate,
                          onPressed: enabled ? onRotate : null,
                          icon: const Icon(Icons.rotate_right),
                        ),
                      if (onRetake != null)
                        IconButton(
                          tooltip: l.cnRetake,
                          onPressed: enabled ? onRetake : null,
                          icon: const Icon(Icons.camera_alt_outlined),
                        ),
                      IconButton(
                        tooltip: l.cnRemovePage,
                        onPressed: enabled ? onDelete : null,
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ReorderableDragStartListener(
              index: index,
              enabled: enabled,
              child: Semantics(
                label: l.cnReorder,
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.drag_handle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _isPdf(Uint8List b) =>
    b.length > 4 &&
    b[0] == 0x25 &&
    b[1] == 0x50 &&
    b[2] == 0x44 &&
    b[3] == 0x46;

String? _sniffImageMime(Uint8List b) {
  if (b.length > 3 && b[0] == 0xFF && b[1] == 0xD8 && b[2] == 0xFF) {
    return 'image/jpeg';
  }
  if (b.length > 8 &&
      b[0] == 0x89 &&
      b[1] == 0x50 &&
      b[2] == 0x4E &&
      b[3] == 0x47) {
    return 'image/png';
  }
  return null;
}

String _mimeFromName(String name) {
  final n = name.toLowerCase();
  if (n.endsWith('.pdf')) return 'application/pdf';
  if (n.endsWith('.png')) return 'image/png';
  if (n.endsWith('.jpg') || n.endsWith('.jpeg')) return 'image/jpeg';
  if (n.endsWith('.heic') || n.endsWith('.heif')) return 'image/heic';
  return 'application/octet-stream';
}

/// Applies the camera's EXIF rotation so the server sees the page upright.
/// Returns null when the image is already upright.
Uint8List? _uprightJpeg(Uint8List bytes) {
  if (_sniffImageMime(bytes) != 'image/jpeg') return null;
  final decoded = img.decodeJpg(bytes);
  if (decoded == null) return null;
  final o = decoded.exif.imageIfd.orientation;
  if (o == null || o == 1) return null;
  return img.encodeJpg(img.bakeOrientation(decoded), quality: 90);
}

Uint8List? _rotateJpeg(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;
  return img.encodeJpg(
    img.copyRotate(img.bakeOrientation(decoded), angle: 90),
    quality: 90,
  );
}
