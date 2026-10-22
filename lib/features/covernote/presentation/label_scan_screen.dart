import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../l10n/app_localizations.dart';
import '../../records/data/medication_repository.dart';
import '../data/ai_extra_client.dart';
import '../data/consent_repository.dart';
import '../domain/s9_models.dart';
import '../ui/app_chrome.dart';
import '../ui/brand.dart';

/// Camera or gallery first. The confirmation form appears after a photo,
/// or when the person chooses to type the name themselves.
class LabelScanScreen extends StatefulWidget {
  const LabelScanScreen({super.key});

  @override
  State<LabelScanScreen> createState() => _LabelScanScreenState();
}

class _LabelScanScreenState extends State<LabelScanScreen> {
  Uint8List? _bytes;
  LabelExtract? _extract;
  String? _error;
  var _busy = false;
  var _manual = false;
  var _cameraOpened = false;
  final _name = TextEditingController();
  final _strength = TextEditingController();
  final _form = TextEditingController();
  final _directions = TextEditingController();

  bool get _showForm => _bytes != null || _manual;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _pick(ImageSource.camera);
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _strength.dispose();
    _form.dispose();
    _directions.dispose();
    super.dispose();
  }

  Future<void> _pick(ImageSource source) async {
    if (source == ImageSource.camera && _cameraOpened && _busy) return;
    if (source == ImageSource.camera) _cameraOpened = true;
    final l = AppLocalizations.of(context)!;
    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 2400,
        maxHeight: 2400,
        imageQuality: 85,
      );
      if (!mounted || file == null) return;
      final bytes = await file.readAsBytes();
      setState(() {
        _bytes = bytes;
        _manual = false;
        _extract = null;
        _error = null;
        _name.clear();
        _strength.clear();
        _form.clear();
        _directions.clear();
      });
      await _read(bytes, file.mimeType ?? 'image/jpeg');
    } on PlatformException {
      if (!mounted) return;
      setState(() {
        _error = source == ImageSource.camera
            ? l.cnCameraUnavailable
            : l.cnPhotosUnavailable;
      });
    }
  }

  Future<void> _read(Uint8List bytes, String mime) async {
    final l = AppLocalizations.of(context)!;
    final consent = ConsentRepository();
    if (!await consent.hasActive(ConsentPurpose.label)) {
      if (!mounted) return;
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l.cnConsentLabel),
          content: Text(l.cnConsentAiBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.cnConsentLater),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.cnConsentAndAnalyze),
            ),
          ],
        ),
      );
      if (ok != true || !mounted) return;
      await consent.accept(ConsentPurpose.label);
    }
    if (!mounted) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final extract = await AiExtraClient().readLabel(bytes, mime);
      if (!mounted) return;
      setState(() {
        _extract = extract;
        _name.text = extract.name ?? '';
        _strength.text = extract.strength ?? '';
        _form.text = extract.form ?? '';
        _directions.text = extract.directions ?? '';
        _busy = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = l.cnErrUnreadable;
          _busy = false;
        });
      }
    }
  }

  String _registeredName() {
    final parts = <String>[_name.text.trim()];
    for (final extra in [_strength.text, _form.text]) {
      final t = extra.trim();
      if (t.isEmpty) continue;
      if (parts.first.toLowerCase().contains(t.toLowerCase())) continue;
      parts.add(t);
    }
    return parts.where((p) => p.isNotEmpty).join(' ');
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context)!;
    final name = _registeredName();
    if (name.isEmpty) return;
    try {
      final existing = await MedicationRepository().list();
      final already = existing.any(
        (m) => m.displayName.trim().toLowerCase() == name.toLowerCase(),
      );
      if (!already) {
        await MedicationRepository().save(
          displayName: name,
          isDefault: false,
          dailyCheckEnabled: false,
        );
      }
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) setState(() => _error = l.s5SaveFailed);
    }
  }

  void _typeInstead() {
    setState(() {
      _manual = true;
      _bytes = null;
      _extract = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CoverNoteAppBar(title: Text(l.cnScanLabel)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Text(
            l.cnLabelNeedLabel,
            style: const TextStyle(fontSize: 16, height: 1.35),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: _busy ? null : () => _pick(ImageSource.camera),
              icon: const Icon(Icons.photo_camera_outlined),
              label: Text(l.cnTakePhoto),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: _busy ? null : () => _pick(ImageSource.gallery),
              icon: const Icon(Icons.photo_library_outlined),
              label: Text(l.cnPickGallery),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: _busy ? null : _typeInstead,
              child: Text(l.cnManualMed),
            ),
          ),
          if (_busy) const LinearProgressIndicator(),
          if (_bytes != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(_bytes!, height: 220, fit: BoxFit.contain),
            ),
          ],
          if (_extract?.needsLabelPhoto == true)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l.cnLabelNeedLabel,
                style: const TextStyle(color: CnColors.warn),
              ),
            ),
          if (_extract != null && _extract!.unclear.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(l.cnLabelUnclear),
            ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _error!,
                style: const TextStyle(color: CnColors.warn),
              ),
            ),
          if (_showForm) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l.cnFieldMedication),
            ),
            TextField(
              controller: _strength,
              decoration: InputDecoration(labelText: l.cnFieldDose),
            ),
            TextField(
              controller: _form,
              decoration: InputDecoration(labelText: l.cnLabelForm),
            ),
            TextField(
              controller: _directions,
              decoration: InputDecoration(labelText: l.cnNoteOptional),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: _busy ? null : _save,
                child: Text(l.cnAdd),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
