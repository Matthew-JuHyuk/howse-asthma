import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/auth/domain/npi_validator.dart';

void main() {
  group('NpiValidator', () {
    test('rejects wrong length', () {
      expect(NpiValidator.isValid('123'), isFalse);
      expect(NpiValidator.isValid('12345678901'), isFalse);
    });

    test('rejects non-digits', () {
      expect(NpiValidator.isValid('123456789a'), isFalse);
    });

    test('accepts a known valid NPI checksum', () {
      // 1245319599 is a commonly cited valid NPI checksum example.
      expect(NpiValidator.isValid('1245319599'), isTrue);
    });

    test('rejects bad checksum', () {
      expect(NpiValidator.isValid('1245319590'), isFalse);
    });
  });
}
