import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/domain/upload_guard.dart';

Uint8List bytes(List<int> head, [int size = 64]) =>
    Uint8List.fromList([...head, ...List.filled(size - head.length, 0)]);

final jpeg = bytes([0xFF, 0xD8, 0xFF, 0xE0]);
final png = bytes([0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);
final pdf = Uint8List.fromList(
  ascii.encode('%PDF-1.7\n1 0 obj\n<<>>\nendobj\n'),
);

UploadReject? check(
  Uint8List b,
  String mime, {
  int caseBytes = 0,
  int pages = 0,
  UploadLimits limits = const UploadLimits(),
}) => inspectUpload(
  bytes: b,
  mime: mime,
  existingCaseBytes: caseBytes,
  existingPages: pages,
  limits: limits,
).reject;

void main() {
  test('accepts JPEG, PNG and PDF when the type matches the content', () {
    expect(check(jpeg, 'image/jpeg'), isNull);
    expect(check(png, 'image/png'), isNull);
    expect(check(pdf, 'application/pdf'), isNull);
  });

  test('rejects a renamed file', () {
    expect(check(png, 'image/jpeg'), UploadReject.badSignature);
    expect(check(jpeg, 'application/pdf'), UploadReject.badSignature);
    expect(
      check(Uint8List.fromList(ascii.encode('hello')), 'text/plain'),
      UploadReject.badSignature,
    );
  });

  test('rejects empty files, HEIC and password-protected PDFs', () {
    expect(check(Uint8List(0), 'image/jpeg'), UploadReject.empty);
    expect(check(jpeg, 'image/heic'), UploadReject.unsupported);
    final locked = Uint8List.fromList(
      ascii.encode('%PDF-1.7\ntrailer\n<< /Encrypt 5 0 R >>\n'),
    );
    expect(check(locked, 'application/pdf'), UploadReject.encryptedPdf);
  });

  test('enforces per-file, per-case and page limits', () {
    const limits = UploadLimits(
      maxFileBytes: 100,
      maxCaseBytes: 150,
      maxPages: 3,
    );
    expect(
      check(bytes([0xFF, 0xD8, 0xFF], 101), 'image/jpeg', limits: limits),
      UploadReject.tooLarge,
    );
    expect(
      check(jpeg, 'image/jpeg', caseBytes: 100, limits: limits),
      UploadReject.caseTooLarge,
    );
    expect(
      check(jpeg, 'image/jpeg', pages: 3, limits: limits),
      UploadReject.tooManyPages,
    );
    expect(check(jpeg, 'image/jpeg', pages: 2, limits: limits), isNull);
  });

  test('default limits are 20 MB per file, 40 MB per case, 10 pages', () {
    const l = UploadLimits();
    expect(l.maxFileBytes, 20 * 1024 * 1024);
    expect(l.maxCaseBytes, 40 * 1024 * 1024);
    expect(l.maxPages, 10);
  });
}
