import 'dart:typed_data';

enum UploadReject {
  empty,
  tooLarge,
  caseTooLarge,
  tooManyPages,
  unsupported,
  badSignature,
  encryptedPdf,
}

class UploadLimits {
  const UploadLimits({
    this.maxFileBytes = 20 * 1024 * 1024,
    this.maxCaseBytes = 40 * 1024 * 1024,
    this.maxPages = 10,
  });

  final int maxFileBytes;
  final int maxCaseBytes;
  final int maxPages;
}

class UploadInspection {
  const UploadInspection(this.reject);

  final UploadReject? reject;
  bool get accepted => reject == null;
}

/// Checks size, declared MIME, and file signature before any analysis call.
UploadInspection inspectUpload({
  required Uint8List bytes,
  required String mime,
  required int existingCaseBytes,
  required int existingPages,
  UploadLimits limits = const UploadLimits(),
}) {
  if (bytes.isEmpty) return const UploadInspection(UploadReject.empty);
  if (bytes.length > limits.maxFileBytes) {
    return const UploadInspection(UploadReject.tooLarge);
  }
  if (existingCaseBytes + bytes.length > limits.maxCaseBytes) {
    return const UploadInspection(UploadReject.caseTooLarge);
  }
  if (existingPages >= limits.maxPages) {
    return const UploadInspection(UploadReject.tooManyPages);
  }

  final normalized = mime.trim().toLowerCase();
  if (normalized == 'image/heic' || normalized == 'image/heif') {
    return const UploadInspection(UploadReject.unsupported);
  }

  final kind = _signatureKind(bytes);
  if (kind == null) return const UploadInspection(UploadReject.badSignature);

  final mimeOk = switch (kind) {
    _Sig.jpeg => normalized == 'image/jpeg',
    _Sig.png => normalized == 'image/png',
    _Sig.pdf => normalized == 'application/pdf',
  };
  if (!mimeOk) return const UploadInspection(UploadReject.badSignature);

  if (kind == _Sig.pdf && _pdfLooksEncrypted(bytes)) {
    return const UploadInspection(UploadReject.encryptedPdf);
  }
  return const UploadInspection(null);
}

enum _Sig { jpeg, png, pdf }

_Sig? _signatureKind(Uint8List bytes) {
  if (bytes.length >= 3 &&
      bytes[0] == 0xFF &&
      bytes[1] == 0xD8 &&
      bytes[2] == 0xFF) {
    return _Sig.jpeg;
  }
  if (bytes.length >= 8 &&
      bytes[0] == 0x89 &&
      bytes[1] == 0x50 &&
      bytes[2] == 0x4E &&
      bytes[3] == 0x47 &&
      bytes[4] == 0x0D &&
      bytes[5] == 0x0A &&
      bytes[6] == 0x1A &&
      bytes[7] == 0x0A) {
    return _Sig.png;
  }
  if (bytes.length >= 5 &&
      bytes[0] == 0x25 &&
      bytes[1] == 0x50 &&
      bytes[2] == 0x44 &&
      bytes[3] == 0x46 &&
      bytes[4] == 0x2D) {
    return _Sig.pdf;
  }
  return null;
}

bool _pdfLooksEncrypted(Uint8List bytes) {
  final slice = bytes.length > 65536 ? bytes.sublist(0, 65536) : bytes;
  final text = String.fromCharCodes(slice);
  return text.contains('/Encrypt');
}
