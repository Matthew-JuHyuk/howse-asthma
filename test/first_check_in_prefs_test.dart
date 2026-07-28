import 'package:flutter_test/flutter_test.dart';

import 'package:howse_asthma/core/onboarding/first_check_in_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FirstCheckInPrefs', () {
    test('isDone false until setBreathing', () async {
      SharedPreferences.setMockInitialValues({});
      expect(await FirstCheckInPrefs.isDone('u1'), isFalse);
      await FirstCheckInPrefs.setBreathing('u1', FirstCheckInPrefs.breathUsual);
      expect(await FirstCheckInPrefs.isDone('u1'), isTrue);
    });

    test('rejects unknown breath id', () async {
      SharedPreferences.setMockInitialValues({});
      await FirstCheckInPrefs.setBreathing('u1', 'invalid');
      expect(await FirstCheckInPrefs.isDone('u1'), isFalse);
    });

    test('shield location prompt flag', () async {
      SharedPreferences.setMockInitialValues({});
      expect(await FirstCheckInPrefs.wasShieldLocationPrompted('u1'), isFalse);
      await FirstCheckInPrefs.setShieldLocationPrompted('u1', true);
      expect(await FirstCheckInPrefs.wasShieldLocationPrompted('u1'), isTrue);
    });
  });
}
