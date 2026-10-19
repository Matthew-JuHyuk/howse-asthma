import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';

/// Local switch for the coverage-letter home.
/// Live document reading is not controlled here.
class V2NavFlag extends ChangeNotifier {
  V2NavFlag._();

  static final V2NavFlag instance = V2NavFlag._();
  static const prefKey = 'v2_navigation_enabled';

  bool enabled = false;
  bool loaded = false;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefKey)) {
      enabled = prefs.getBool(prefKey) ?? false;
    } else {
      enabled = AppConfig.v2NavigationEnabled;
    }
    loaded = true;
    notifyListeners();
  }

  Future<void> setEnabled(bool value) async {
    enabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefKey, value);
    notifyListeners();
  }
}
