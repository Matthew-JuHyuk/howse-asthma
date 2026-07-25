import 'package:flutter/material.dart';

import '../screen_ids.dart';
import 'auth_mock_screens.dart';
import 'patient_mock_screens.dart';
import 'system_mock_screens.dart';

class MockScreenFactory {
  MockScreenFactory._();

  static Widget build(MockScreenId id) {
    switch (id) {
      case MockScreenId.auth01:
        return const Auth01SplashMock();
      case MockScreenId.auth02:
        return const Auth02LoginMock();
      case MockScreenId.auth03:
        return const Auth03SignUpMock();
      case MockScreenId.auth04:
        return const Auth04BiometricMock();
      case MockScreenId.onb01:
        return const Onb01PatientMock();
      case MockScreenId.patHome:
        return const PatHomeMock(warning: false);
      case MockScreenId.patHomeWarn:
        return const PatHomeMock(warning: true);
      case MockScreenId.patEnv:
        return const PatEnvMock();
      case MockScreenId.patForecast:
        return const PatForecastMock();
      case MockScreenId.patLog:
        return const PatLogMock();
      case MockScreenId.patAct:
        return const PatActMock();
      case MockScreenId.patPdc:
        return const PatPdcMock();
      case MockScreenId.patReport:
        return const PatReportMock();
      case MockScreenId.patLocations:
        return const PatLocationsMock();
      case MockScreenId.patReward:
        return const PatRewardMock();
      case MockScreenId.patVoucher:
        return const PatVoucherMock();
      case MockScreenId.patDonate:
        return const PatDonateMock();
      case MockScreenId.patRewardHist:
        return const PatRewardHistMock();
      case MockScreenId.patSettings:
        return const PatSettingsMock();
      case MockScreenId.sysAlert:
        return const SysAlertMock();
      case MockScreenId.sysPanic:
        return const SysPanicMock();
      case MockScreenId.sysPanicStep2:
        return const SysPanicStep2Mock();
    }
  }
}
