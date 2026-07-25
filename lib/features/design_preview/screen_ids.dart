/// Screen IDs for patient design-preview mockups (nav-only).
enum MockScreenId {
  auth01('SCR-AUTH-01', 'Splash / Auth Gate'),
  auth02('SCR-AUTH-02', 'Login'),
  auth03('SCR-AUTH-03', 'Sign up · role'),
  auth04('SCR-AUTH-04', 'Biometric lock'),
  onb01('SCR-ONB-01', 'Patient onboarding'),
  patHome('SCR-PAT-HOME', 'Home (CALM)'),
  patHomeWarn('SCR-PAT-HOME.warn', 'Home (WARNING)'),
  patEnv('SCR-PAT-ENV', 'Environment detail'),
  patForecast('SCR-PAT-FORECAST', 'Forecast'),
  patLog('SCR-PAT-LOG', 'Log timeline'),
  patAct('SCR-PAT-ACT', 'ACT survey'),
  patPdc('SCR-PAT-PDC', 'Daily PDC'),
  patReport('SCR-PAT-REPORT', 'Evidence summary'),
  patLocations('SCR-PAT-LOCATIONS', 'Saved locations'),
  patReward('SCR-PAT-REWARD', 'Points hub'),
  patVoucher('SCR-PAT-VOUCHER', 'Voucher exchange'),
  patDonate('SCR-PAT-DONATE', 'In-app donate'),
  patRewardHist('SCR-PAT-REWARD-HIST', 'Reward history'),
  patSettings('SCR-PAT-SETTINGS', 'Patient settings'),
  sysAlert('SCR-SYS-ALERT', 'Risk alert'),
  sysPanic('SCR-SYS-PANIC', 'Panic Step 1'),
  sysPanicStep2('SCR-SYS-PANIC.step2', 'Panic Step 2');

  const MockScreenId(this.id, this.label);

  final String id;
  final String label;

  static const List<MockScreenId> all = MockScreenId.values;
}
