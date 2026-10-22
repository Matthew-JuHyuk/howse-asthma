// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginEmailLabel => 'البريد الإلكتروني';

  @override
  String get loginPasswordLabel => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get signUpButton => 'إنشاء حساب';

  @override
  String get supabaseNotConfigured =>
      'Supabase is not configured yet.\nAdd SUPABASE_URL and SUPABASE_ANON_KEY to your .env file.';

  @override
  String get homeGreeting => 'Hello';

  @override
  String get homeAirQualityTitle => 'Air Quality Near You';

  @override
  String get homeWeatherTitle => 'Weather Near You';

  @override
  String get asthmaRiskLow => 'Low asthma risk';

  @override
  String get asthmaRiskModerate => 'Moderate asthma risk';

  @override
  String get asthmaRiskHigh => 'High asthma risk - take precautions';

  @override
  String get medicationLogTitle => 'Medication Log';

  @override
  String get medicationLogAddButton => 'تسجيل استخدام البخاخ / الدواء';

  @override
  String get medicationNameLabel => 'Medication Name';

  @override
  String get medicationDoseLabel => 'Dose';

  @override
  String get medicationTimeLabel => 'Time Taken';

  @override
  String get medicationEffectivenessLabel => 'Did it help?';

  @override
  String get reportTitle => 'Insurance Report';

  @override
  String get reportGenerateButton => 'Generate Report for Doctor / Insurance';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguageLabel => 'اللغة';

  @override
  String get settingsLocationLabel => 'Location';

  @override
  String get notificationAttackWarningTitle => 'Asthma Attack Risk Alert';

  @override
  String get mockContinue => 'متابعة';

  @override
  String get mockSignUpTitle => 'Create account';

  @override
  String get mockChooseRole => 'Choose your role';

  @override
  String get mockRolePatient => 'Patient';

  @override
  String get mockRolePatientHint => 'Track air risk and inhaler use';

  @override
  String get mockRoleProvider => 'Provider';

  @override
  String get mockRoleProviderHint => 'Not in this design preview';

  @override
  String get mockProviderNotInPreview =>
      'Provider screens are not in this patient design preview.';

  @override
  String get mockBiometricTitle => 'Unlock';

  @override
  String get mockBiometricHint =>
      'Use biometrics to unlock Howse Asthma (design preview).';

  @override
  String get mockUnlock => 'فتح القفل';

  @override
  String get mockUsePassword => 'استخدم كلمة المرور بدلا من ذلك';

  @override
  String get mockOnboardingTitle => 'Patient setup';

  @override
  String get mockHomeLocation => 'المنزل';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'جهة اتصال للطوارئ';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'رمز دعوة مقدم الرعاية';

  @override
  String get mockFinishOnboarding => 'Go to home';

  @override
  String get mockAllScreens => 'كل الشاشات';

  @override
  String get mockAllScreensHint => 'Open any Screen ID for design review';

  @override
  String get mockStateCalm => 'هادئ';

  @override
  String get mockStateWarning => 'تحذير';

  @override
  String get mockHomeCalmMessage =>
      'Air looks manageable nearby. Log inhaler use anytime.';

  @override
  String get mockHomeWarnMessage =>
      'Elevated risk nearby. Limit outdoor exposure and keep your inhaler ready.';

  @override
  String get mockRiskScore => 'Risk score';

  @override
  String get mockDummyLocation => 'Near Newark, NJ';

  @override
  String get mockEnvDetail => 'Environment detail';

  @override
  String get mockForecast => 'التوقعات';

  @override
  String get mockForecastHint => 'Next days air & pollen outlook';

  @override
  String get mockAlertPreview => 'Alert landing';

  @override
  String get mockAlertPreviewHint => 'Preview risk alert screen';

  @override
  String get mockShowWarningHome => 'معاينة الشاشة الرئيسية في حالة التحذير';

  @override
  String get mockBackToCalmHome => 'رجوع';

  @override
  String get mockPanicCta => 'Panic mode';

  @override
  String get mockTrapAxis => 'TRAP / السخام';

  @override
  String get mockFloodAxis => 'فيضان مفاجئ';

  @override
  String get mockPollenAxis => 'حبوب اللقاح';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · Pollen outlook';

  @override
  String get mockActSurvey => 'استبيان ACT';

  @override
  String get mockActHint => '5 أسئلة مصورة (آخر 4 أسابيع)';

  @override
  String get mockPdcCheck => 'فحص PDC اليومي';

  @override
  String get mockPdcHint => 'التزام بلمسة واحدة';

  @override
  String get mockInhalerEvent => 'تم تسجيل استخدام البخاخ';

  @override
  String get mockActIntro =>
      'Answer based on the last 4 weeks. Design preview — answers are not saved.';

  @override
  String get mockQuestion => 'سؤال';

  @override
  String get mockSubmit => 'إرسال';

  @override
  String get mockPdcPrompt => 'هل تناولت دواء السيطرة اليومي اليوم؟';

  @override
  String get mockTakenYes => 'نعم، تناولته';

  @override
  String get mockTakenNo => 'ليس اليوم';

  @override
  String get mockEvidenceSummary => 'Your evidence summary';

  @override
  String get mockEvidenceBody =>
      'Dummy summary for PA/LMN support. Design preview only.';

  @override
  String get mockInhalerEvents30d => 'Inhaler events (30d)';

  @override
  String get mockActScore => 'آخر نتيجة ACT';

  @override
  String get mockPdcRate => 'PDC (30 يوما)';

  @override
  String get mockLocationsTitle => 'الأماكن المحفوظة';

  @override
  String get mockLocationsHint => 'مراقبة المنزل والعمل';

  @override
  String get mockWorkLocation => 'العمل';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => 'إضافة مكان';

  @override
  String get mockRewardTitle => 'Rewards';

  @override
  String get mockDraftBanner => 'مسودة — النقاط والقسائم للمعاينة فقط';

  @override
  String get mockPointsBalance => 'رصيد النقاط';

  @override
  String get mockVoucherTitle => 'قسيمة بنك الطعام';

  @override
  String get mockVoucherHint => 'Exchange points (waitlist)';

  @override
  String get mockDonateTitle => 'تبرع';

  @override
  String get mockDonateHint => 'التبرع عبر جهة خارجية فقط';

  @override
  String get mockRewardHistory => 'السجل';

  @override
  String get mockRewardHistoryHint => 'النقاط والتبرعات';

  @override
  String get mockDummyFoodBank => 'بنك الطعام المجتمعي في NJ (تجريبي)';

  @override
  String get mockVoucherCost => '50 نقطة · قيمة \$10 (مسودة)';

  @override
  String get mockJoinWaitlist => 'انضم إلى قائمة الانتظار';

  @override
  String get mockDonateTransparency =>
      'تتم التبرعات عبر منصة موثوقة تابعة لجهة غير ربحية من طرف ثالث. لا يحفظ Howse Asthma بيانات البطاقة أبدا.';

  @override
  String get mockDonateCta => 'فتح صفحة التبرع (خارجية)';

  @override
  String get mockExternalOnly =>
      'جهة التبرع الخارجية غير مرتبطة في المعاينة التصميمية.';

  @override
  String get mockSignOutPreview => 'تسجيل الخروج (معاينة)';

  @override
  String get mockOpenAuthFlow => 'Open auth flow';

  @override
  String get mockAlertBody =>
      'Risk rose near your location. Review environment details.';

  @override
  String get mockDismiss => 'إغلاق';

  @override
  String get mockPanicTitle => 'Need help now?';

  @override
  String get mockPanicStep1Body =>
      'الخطوة 1 — ابق مع بخاخك. تابع للوصول إلى جهات اتصال الطوارئ.';

  @override
  String get mockPanicStep2Title => 'اطلب المساعدة';

  @override
  String get mockPanicStep2Body =>
      'معاينة تصميمية: الأزرار لا تجري اتصالا حقيقيا. في النسخ على الأجهزة، تستخدم الخطوة 2 روابط tel:.';

  @override
  String get mockCall911 => 'اتصل بـ 911';

  @override
  String get mockCallGuardian => 'اتصل بجهة اتصال الطوارئ';

  @override
  String get mockFeelingBetter => 'أشعر بتحسن';

  @override
  String get mockTabHome => 'الرئيسية';

  @override
  String get mockTabLog => 'السجل';

  @override
  String get mockTabReport => 'التقرير';

  @override
  String get mockTabReward => 'المكافآت';

  @override
  String get mockTabSettings => 'الإعدادات';

  @override
  String get navHome => 'Home';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get authChooseRole => 'اختر دورك';

  @override
  String get authRolePatient => 'مريض';

  @override
  String get authRolePatientHint => 'Track air quality risk and inhaler use';

  @override
  String get authRoleProvider => 'مقدم رعاية';

  @override
  String get authRoleProviderHint =>
      'Link patients and review clinical evidence';

  @override
  String get authFullNameLabel => 'الاسم الكامل';

  @override
  String get authNpiLabel => 'رقم NPI';

  @override
  String get authNpiHelper => 'الرقم الوطني لمقدم الرعاية (NPI) من 10 أرقام';

  @override
  String get authOrContinueWith => 'أو تابع باستخدام';

  @override
  String get authContinueGoogle => 'المتابعة باستخدام Google';

  @override
  String get authContinueApple => 'المتابعة باستخدام Apple';

  @override
  String get authCheckEmailTitle => 'Check your email';

  @override
  String authCheckEmailBody(String email) {
    return 'We sent a confirmation link to $email. Open it, then sign in.';
  }

  @override
  String get authBackToSignIn => 'Back to sign in';

  @override
  String get authCompleteProfileTitle => 'Complete your profile';

  @override
  String get authCompleteProfileBody =>
      'Tell us who you are so we can open the right home screen.';

  @override
  String get authSaveProfile => 'Save profile';

  @override
  String get authSignOut => 'تسجيل الخروج';

  @override
  String get authRetry => 'إعادة المحاولة';

  @override
  String get authWorking => 'جارٍ العمل…';

  @override
  String get authValidationInvalidEmail => 'Enter a valid email';

  @override
  String get authValidationPasswordMin =>
      'Password must be at least 8 characters';

  @override
  String get authValidationNameRequired => 'Name is required';

  @override
  String get authValidationInvalidNpi => 'Enter a valid 10-digit NPI';

  @override
  String get authErrorGeneric => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get authErrorInvalidCredentials => 'Invalid email or password';

  @override
  String get authErrorEmailTaken => 'An account with this email already exists';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirm your email before signing in';

  @override
  String get authErrorWeakPassword => 'Password is too weak';

  @override
  String get authErrorRateLimited => 'Too many attempts. Try again later.';

  @override
  String get authBiometricTitle => 'فتح Howse Asthma';

  @override
  String get authBiometricHint => 'استخدم بصمتك أو وجهك للمتابعة';

  @override
  String get authBiometricReason => 'فتح Howse Asthma';

  @override
  String get authBiometricUnlock => 'Unlock';

  @override
  String get authBiometricFailed => 'Biometric unlock failed. Try again.';

  @override
  String get authBiometricToggle => 'الفتح بالبصمة أو الوجه';

  @override
  String get authBiometricToggleHint =>
      'اطلب الفتح بالبصمة أو الوجه عند فتح التطبيق';

  @override
  String get authBiometricUnavailable =>
      'البصمة أو الوجه غير متاحة على هذا الجهاز';

  @override
  String get authOnboardingTitle => 'إعداد حساب المريض';

  @override
  String get authOnboardingBody =>
      'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.';

  @override
  String get authOnboardingSkip => 'تخطَّ الآن';

  @override
  String get authInviteCodeLabel => 'رمز دعوة مقدم الرعاية';

  @override
  String get authInviteCodeHelper => '8 أحرف/أرقام، ينتهي بعد 24 ساعة';

  @override
  String get authInviteRedeem => 'Redeem';

  @override
  String get authInviteRedeemAndContinue => 'Redeem and continue';

  @override
  String get authInviteInvalidFormat =>
      'Invite code must be 8 letters or numbers';

  @override
  String get authInviteRedeemedPending =>
      'Invite redeemed. Waiting for provider confirmation.';

  @override
  String get authInviteRedeemFailed => 'Could not redeem invite code';

  @override
  String get authInviteIssueFailed => 'تعذر إصدار رمز الدعوة';

  @override
  String get authConfirmLink => 'تأكيد';

  @override
  String get authRejectLink => 'رفض';

  @override
  String get authLinkStatusPending => 'بانتظار التأكيد';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get settingsLocationTodo =>
      'Location permission will be requested in a later update';

  @override
  String get providerHomeTab => 'الرئيسية';

  @override
  String get providerLinkTab => 'الربط';

  @override
  String get providerHomeTitle => 'الرئيسية لمقدم الرعاية';

  @override
  String providerHomeWelcome(String email) {
    return 'تم تسجيل الدخول باسم $email';
  }

  @override
  String get providerHomePlaceholder =>
      'لوحات المعلومات السريرية للمرضى ستتوفر في إصدار لاحق. ابدأ بربط المرضى.';

  @override
  String get providerLinkPatientsCta => 'ربط المرضى';

  @override
  String get providerLinkTitle => 'ربط المرضى';

  @override
  String get providerLinkIntro =>
      'أصدر رمزا من 8 أحرف (صالحا لمدة 24 ساعة). يدخله المريض، ثم يؤكد الطرفان.';

  @override
  String get providerIssueInviteCta => 'إصدار رمز دعوة';

  @override
  String get providerInviteTtlHint => 'صالح لمدة 24 ساعة';

  @override
  String get providerInviteCopied => 'تم نسخ رمز الدعوة';

  @override
  String get providerPendingLinks => 'طلبات الربط المعلقة';

  @override
  String get providerNoPendingLinks => 'لا توجد طلبات ربط معلقة';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'المريض $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'رموز الدعوة الأخيرة';

  @override
  String get providerNoInvites => 'لا توجد رموز دعوة بعد';

  @override
  String get providerInviteConsumed => 'مستخدم';

  @override
  String get providerInviteActive => 'نشط';

  @override
  String get splashTagline => 'درعك الذكي ضد المحفزات';

  @override
  String get splashGetStarted => 'ابدأ';

  @override
  String get splashAlreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get splashSignIn => 'تسجيل الدخول';

  @override
  String get authForgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get authNoAccount => 'ليس لديك حساب؟';

  @override
  String get authUseBiometricHint => 'استخدم بصمة الوجه أو الإصبع لفتح القفل';

  @override
  String get authTouchSensorHint => 'المس المستشعر أو انظر إلى الكاميرا';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => 'اختر اللغة';

  @override
  String get mockYourLocation => 'موقعك';

  @override
  String get mockUseCurrentLocation => 'استخدم الموقع الحالي';

  @override
  String get mockLocationTrapOnly =>
      'يُستخدم الموقع لبيانات جودة الهواء TRAP فقط';

  @override
  String get mockLabelYourPlace => 'سمِّ مكانك';

  @override
  String get mockSchool => 'المدرسة';

  @override
  String get mockWork => 'العمل';

  @override
  String get mockOther => 'أخرى';

  @override
  String get mockEmergencyOnePerson => 'شخص واحد يُتصل به في الطوارئ';

  @override
  String get mockContactName => 'اسم جهة الاتصال';

  @override
  String get mockPhoneNumber => 'رقم الهاتف';

  @override
  String get mockProviderPairing => 'الربط بمقدم الرعاية';

  @override
  String get mockPairingOptional => 'اختياري — يمكنك إضافته لاحقا في الإعدادات';

  @override
  String get mockNext => 'التالي';

  @override
  String get mockProfessionalProfile => 'الملف المهني';

  @override
  String get mockStep2Of4 => 'الخطوة 2 من 4';

  @override
  String get mockTellPractice => 'أخبرنا عن ممارستك الطبية';

  @override
  String get mockSpecialtyLabel => 'التخصص';

  @override
  String get mockClinicLabel => 'اسم العيادة / مكان الممارسة';

  @override
  String get mockNpiFormatOnly =>
      'فحص الصيغة فقط. يتم التحقق من رقم NPI بعد الإرسال.';

  @override
  String get mockCredentialsSecure =>
      'بيانات اعتمادك مشفرة ومحفوظة بأمان. لا نشارك بيانات مقدم الرعاية دون موافقة.';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => 'Inhaler use logged (stub)';

  @override
  String get oneTapLoggedOk => 'Inhaler use logged';

  @override
  String get oneTapLoggedFailed => 'Could not log inhaler use. Try again.';

  @override
  String get homeDailySummary => 'Here is your daily summary';

  @override
  String get homeWarningBanner =>
      'Elevated risk nearby. Limit outdoor exposure and keep your inhaler ready.';

  @override
  String get homeEnvFactors => 'Environmental Factors';

  @override
  String get homeViewDetails => 'View details';

  @override
  String get homeFloodActive => 'Active warning';

  @override
  String get homeFloodNone => 'None';

  @override
  String get homeLastInhalerNone => 'No inhaler use logged yet';

  @override
  String get homeLastInhalerToday => 'Last inhaler use: today';

  @override
  String homeLastInhalerDays(int days) {
    return 'Last inhaler use: $days days ago';
  }

  @override
  String get locationServiceDisabled =>
      'Turn on location services to see nearby asthma risk.';

  @override
  String get locationPermissionDenied =>
      'Location permission is needed for air quality near you.';

  @override
  String get locationPermissionDeniedForever =>
      'Location permission is blocked. Open settings to allow it.';

  @override
  String get locationUnavailable =>
      'Could not get your location. Pull to refresh or try again.';

  @override
  String get locationOutOfServiceArea =>
      'Howse Asthma currently supports locations in the United States.';

  @override
  String get locationOpenSettings => 'Open settings';

  @override
  String get locationStatusGranted => 'Location access is on';

  @override
  String get njOnlyDataNotice =>
      'NJ-only data: freight AADT weighting applies in New Jersey only. TRAP still uses air-quality sensors nationwide.';

  @override
  String get homeDegradedNotice =>
      'Some air-quality sources are unavailable. Risk may be incomplete — treat with caution.';

  @override
  String logWeekSummary(int count) {
    return '$count inhaler events in the last 7 days';
  }

  @override
  String get logFilterAll => 'All';

  @override
  String get logFilterRescue => 'Rescue';

  @override
  String get logFilterPanic => 'Panic';

  @override
  String get logEmpty => 'No inhaler events yet. Use 1-Tap on Home.';

  @override
  String get logEventRescue => 'Inhaler use';

  @override
  String get logEventPanic => 'Panic inhaler use';

  @override
  String get actTitle => 'Asthma Check';

  @override
  String get actPast4Weeks => 'خلال آخر 4 أسابيع';

  @override
  String get actQ1 =>
      'ما مقدار الوقت الذي منعك فيه الربو من إنجاز أعمالك في العمل أو المدرسة أو المنزل؟';

  @override
  String get actQ2 => 'كم مرة شعرت بضيق في التنفس؟';

  @override
  String get actQ3 =>
      'كم مرة أيقظتك أعراض الربو في الليل أو في وقت أبكر من المعتاد؟';

  @override
  String get actQ4 => 'كم مرة استخدمت بخاخ الإنقاذ أو دواء جهاز الرذاذ؟';

  @override
  String get actQ5 => 'كيف تقيّم سيطرتك على الربو؟';

  @override
  String get actOpt1 => 'طوال الوقت';

  @override
  String get actOpt2 => 'معظم الوقت';

  @override
  String get actOpt3 => 'بعض الوقت';

  @override
  String get actOpt4 => 'قليلا من الوقت';

  @override
  String get actOpt5 => 'أبدا';

  @override
  String get actQ5Opt1 => 'غير مسيطر عليه إطلاقا';

  @override
  String get actQ5Opt2 => 'السيطرة ضعيفة';

  @override
  String get actQ5Opt3 => 'السيطرة متوسطة';

  @override
  String get actQ5Opt4 => 'السيطرة جيدة';

  @override
  String get actQ5Opt5 => 'السيطرة كاملة';

  @override
  String actSaved(int score) {
    return 'ACT saved. Score: $score';
  }

  @override
  String get pdcTitle => 'Daily medicine check';

  @override
  String get pdcSaved => 'Daily check saved';

  @override
  String get pdcAlreadyYes =>
      'You already marked today as taken. You can update it.';

  @override
  String get pdcAlreadyNo =>
      'You already marked today as not taken. You can update it.';

  @override
  String pdcStreakHint(int taken, int total, String rate) {
    return 'Last 30 days: $taken of $total days taken ($rate)';
  }

  @override
  String get panicEmergencyBadge => 'EMERGENCY';

  @override
  String get panicBreatheTitle => 'Breathe & Use Inhaler';

  @override
  String get panicTakeInhalerNow => 'Take Inhaler Now';

  @override
  String get panicNeedHelp => 'I need more help';

  @override
  String get panicNoAutoDial =>
      'الأزرار تفتح تطبيق الاتصال في الهاتف. لا تُجرى المكالمات تلقائيا أبدا.';

  @override
  String panicCallNamed(String name) {
    return 'اتصل بـ $name';
  }

  @override
  String get panicDialFailed => 'تعذر فتح تطبيق الاتصال على هذا الجهاز.';

  @override
  String get alertTitle => 'Risk alert';

  @override
  String get alertFcmPendingNote =>
      'If push is enabled on this device, you also get an OS notification when the app is in the background.';

  @override
  String get reportEvidenceBody =>
      'Summary of inhaler use, ACT, and PDC for clinician or insurance review.';

  @override
  String get reportShareTodo =>
      'Share / export will arrive with provider PA/LMN flow.';

  @override
  String get settingsAlertsTitle => 'Alert Preferences';

  @override
  String get settingsAlertRisk => 'Risk Alerts';

  @override
  String get settingsAlertRiskHint =>
      'When your composite risk score reaches 3 or higher';

  @override
  String get settingsAlertHome => 'Saved place alerts';

  @override
  String get settingsAlertHomeHint =>
      'When risk rises at places you saved (home, school, work)';

  @override
  String get settingsAlertLocationEntry => 'Location entry alerts';

  @override
  String get settingsAlertLocationEntryHint =>
      'When you move into a higher-risk area while the app is open';

  @override
  String get settingsSecurityTitle => 'Security';

  @override
  String get emergencyContactRequired =>
      'Enter a contact name and phone number';

  @override
  String get emergencyContactInvalidPhone =>
      'Enter a valid phone with country code (E.164), e.g. +15551234567';

  @override
  String get emergencyContactSaved => 'Emergency contact saved';

  @override
  String get emergencyContactSave => 'Save contact';

  @override
  String get emergencyContactPhoneHint =>
      'Include country code (E.164), e.g. +15551234567';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get envTitle => 'Environment';

  @override
  String get envThreeAxis => 'Three risk axes';

  @override
  String get envTrapDetail =>
      'مؤشر الهواء المرتبط بالمرور (أجهزة استشعار، وفي نيوجيرسي وزن اختياري لحركة الشحن).';

  @override
  String get envTrapTip =>
      'Limit outdoor exertion when TRAP is HIGH or CRITICAL.';

  @override
  String get envFloodDetail =>
      'تنبيهات الفيضان المفاجئ والمجاري من NWS بالقرب منك.';

  @override
  String get envFloodTipClear => 'No active flash-flood warning for this area.';

  @override
  String get envPollenDetail => 'توقعات حبوب اللقاح من Google.';

  @override
  String get envPollenTip =>
      'Keep windows closed and rinse after outdoor time when UPI is high.';

  @override
  String envUsgsRate(String rate) {
    return 'USGS stream change: $rate ft/hr';
  }

  @override
  String envUpdatedAt(String when) {
    return 'آخر تحديث: $when';
  }

  @override
  String get envSourcesLabel => 'Data sources';

  @override
  String get envOverallCalm =>
      'Conditions look manageable. Keep your inhaler nearby.';

  @override
  String get forecastIntro =>
      'Outlook for the next periods using air quality and pollen forecasts.';

  @override
  String get forecastEmpty =>
      'Forecast series is not available yet. Pull to refresh.';

  @override
  String get forecastPollenNote =>
      'Pollen uses Google Pollen API (not Open-Meteo). Heatmaps are not used in MVP.';

  @override
  String forecastDayPollen(int upi, String type) {
    return 'Pollen UPI $upi · $type';
  }

  @override
  String forecastDayAqi(int aqi) {
    return 'Max US AQI $aqi';
  }

  @override
  String get forecastMorning => 'Morning';

  @override
  String get forecastAfternoon => 'Afternoon';

  @override
  String get forecastEvening => 'Evening';

  @override
  String get locationsTitle => 'My Locations';

  @override
  String get locationsIntro =>
      'Saved places are checked for risk changes while the app is open. Background OS push needs Firebase (next).';

  @override
  String get locationsEmpty =>
      'No saved places yet. Add your current location.';

  @override
  String get locationsAddTitle => 'Save this place';

  @override
  String get locationsNameLabel => 'Label';

  @override
  String get locationsAddCurrent => 'Add current location';

  @override
  String get locationsSaveFailed =>
      'Could not update saved locations. Try again.';

  @override
  String get locationsCapReached =>
      'You can save up to 10 places. Remove one to add another.';

  @override
  String get locationsDeleteTitle => 'Remove place?';

  @override
  String locationsDeleteBody(String name) {
    return 'Remove “$name” from monitoring?';
  }

  @override
  String locationsCoords(String lat, String lon) {
    return '$lat, $lon';
  }

  @override
  String get locationsPrimaryBadge => 'Primary';

  @override
  String get stateOnlyNjApplied => 'NJ-only: freight AADT weight applied';

  @override
  String get stateOnlyNjNotApplied =>
      'NJ-only: freight AADT weight not applied';

  @override
  String get stateOnlyNjAppliedHint =>
      'Nearby NJDOT traffic counts raised the TRAP weight. Air quality sensors still apply nationwide.';

  @override
  String get stateOnlyNjOutsideHint =>
      'You are outside New Jersey. Freight AADT weighting is NJ-only; TRAP still uses air sensors.';

  @override
  String get stateOnlyNjNoCountHint =>
      'No nearby NJDOT freight count. TRAP uses air-quality sensors without the NJ freight weight.';

  @override
  String get settingsDeveloperSection => 'Developer';

  @override
  String get settingsApiConsole => 'API Console';

  @override
  String get debugApiConsoleBanner =>
      'DEBUG — do not screenshot for public share';

  @override
  String get appTagline => 'Your smart shield against triggers';

  @override
  String get welcomeBenefit1 =>
      'Proactive alerts for air quality & pollen risk';

  @override
  String get welcomeBenefit2 =>
      'A 3-second daily check-in for breathing control';

  @override
  String get welcomeBenefit3 =>
      'Trusted data reports you can share with your clinician';

  @override
  String get welcomeContinueEmail => 'or continue with email';

  @override
  String get welcomeTermsAgree =>
      'I agree to the Terms of Service and Privacy Policy';

  @override
  String get welcomeTermsPending =>
      'Legal document links will be available once published.';

  @override
  String get welcomeClinicianLink => 'I\'m a clinician';

  @override
  String get checkInWelcomeHome => 'Welcome Home!';

  @override
  String get checkInQuestion => 'How is your breathing right now?';

  @override
  String get checkInBreathUsual => 'About the same as usual';

  @override
  String get checkInBreathTight => 'A bit tight';

  @override
  String get checkInBreathSymptoms => 'I have symptoms';

  @override
  String get checkInAeroPoints => 'First check-in done! +5 AeroPoints';

  @override
  String get shieldLocationTitle => 'Activate your preemptive shield';

  @override
  String get shieldLocationBody =>
      'Turn on your preemptive shield around you — we need location for nearby air & pollen.';

  @override
  String get shieldLocationAllow => 'Allow location';

  @override
  String get shieldLocationNotNow => 'Not now';

  @override
  String get settingsPushMaster => 'Push notifications';

  @override
  String get settingsPushMasterHint =>
      'Master switch for all Howse Asthma alerts on this device';

  @override
  String get pushConsentTitle => 'Stay ahead of asthma triggers';

  @override
  String get pushConsentBody =>
      'We can send simple alerts when nearby air or flood risk rises, and later tips for safer times to open windows. You can change this anytime in Settings.';

  @override
  String get pushConsentAllow => 'Allow notifications';

  @override
  String get pushConsentNotNow => 'Not now';

  @override
  String homeNearPlace(String place) {
    return 'Near $place';
  }

  @override
  String get homeStaleLocationNotice =>
      'Showing your last saved reading while we wait for location.';

  @override
  String get homeStaleRefreshNotice =>
      'Showing your last saved reading. Pull to refresh when you have a connection.';

  @override
  String get homeStaleCacheNotice =>
      'This reading may be a little old. Treat with care.';

  @override
  String get homeNowDoThisHeading =>
      'Do this now to lower your chance of an attack';

  @override
  String get homeDraftBadge => 'Draft';

  @override
  String get homeNowDoThisFloodTitle => 'Stay inside if you can';

  @override
  String get homeNowDoThisFloodBody =>
      'Flood alerts often mean damp rooms. Keep your inhaler close and avoid flooded areas.';

  @override
  String get homeNowDoThisTrapTitle => 'Ease up on outdoor activity';

  @override
  String get homeNowDoThisTrapBody =>
      'Traffic-related air pollution nearby looks high. Short outdoor trips only if needed.';

  @override
  String get homeNowDoThisPollenTitle => 'Keep windows closed for now';

  @override
  String get homeNowDoThisPollenBody =>
      'Pollen is high. Rinse face and change clothes after being outside.';

  @override
  String get homeNowDoThisRiskTitle => 'Slow down outdoors';

  @override
  String get homeNowDoThisRiskBody =>
      'Overall risk is elevated. Keep your inhaler with you and rest if breathing feels hard.';

  @override
  String get homeNowDoThisCalmTitle => 'A calmer window for fresh air';

  @override
  String get homeNowDoThisCalmBody =>
      'Outside air looks manageable. A short air-out may help — still keep your inhaler nearby.';

  @override
  String get homeAdherenceSection => 'Your inhaler week';

  @override
  String get adherenceWeekHint =>
      'Filled days show logged inhaler uses (1-Tap).';

  @override
  String get homeMoldAxis => 'Mold risk';

  @override
  String get homeMoldElevatedDraft => 'Higher dampness signal';

  @override
  String get homeMoldPendingDraft => 'Humidity data pending';

  @override
  String get homeFloodAsMoldFactor => 'Flood / damp factor';

  @override
  String get homeForecastLink => 'Short outlook';

  @override
  String homeForecastHint(String date, String score) {
    return 'Next day $date · score $score';
  }

  @override
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  ) {
    return 'Nearest air sensor $km km ($mi mi) · search ~$radiusKm km ($radiusMi mi)';
  }

  @override
  String homeSensorNearestOnly(String km, String mi) {
    return 'Nearest air sensor $km km ($mi mi)';
  }

  @override
  String homeSensorRadiusOnly(String km, String mi) {
    return 'Sensor search ~$km km ($mi mi)';
  }

  @override
  String get weekdayMonShort => 'M';

  @override
  String get weekdayTueShort => 'T';

  @override
  String get weekdayWedShort => 'W';

  @override
  String get weekdayThuShort => 'T';

  @override
  String get weekdayFriShort => 'F';

  @override
  String get weekdaySatShort => 'S';

  @override
  String get weekdaySunShort => 'S';

  @override
  String get logAdherenceCalendarTitle => 'Adherence calendar';

  @override
  String get homeNowDoThisMoldTitle => 'Cut down indoor dampness';

  @override
  String get homeNowDoThisMoldBody =>
      'Outdoor dampness looks high. Run a fan or dehumidifier if you have one, and avoid wet basements.';

  @override
  String get homeMoldDetail =>
      'Dampness conditions near you (outdoor proxy — not a spore count)';

  @override
  String get homeMoldTip =>
      'High mold risk means keep rooms drier when you can. Flood warnings raise dampness risk.';

  @override
  String homeMoldRh(String pct) {
    return 'Humidity $pct%';
  }

  @override
  String homeMoldTempF(String temp) {
    return '$temp°F';
  }

  @override
  String homeMoldDewF(String temp) {
    return 'Dew $temp°F';
  }

  @override
  String homeMoldWetHours(int hours) {
    return '$hours wet hours (24h)';
  }

  @override
  String get homeMoldProxyDisclaimer => 'Outdoor estimate only';

  @override
  String get homeVentilationSnack =>
      'Outside air looks calmer — a short air-out may help.';

  @override
  String get settingsAlertPositive => 'Fresh-air tips';

  @override
  String get settingsAlertPositiveHint =>
      'When outdoor air looks safer for a short window open (draft rules)';

  @override
  String get settingsBgTitle => 'Background refresh';

  @override
  String get settingsBgBody =>
      'Howse Asthma refreshes nearby air while you use the app. We do not request Always location in this version.';

  @override
  String get settingsBgRefresh => 'Refresh while using the app';

  @override
  String get settingsBgRefreshHint =>
      'Update risk when you move or keep the app open';

  @override
  String get s5AboutApp => 'About Howse Asthma';

  @override
  String get s5AboutAppBody =>
      'Howse Asthma helps you keep a record of symptoms and inhaler use and prepare a summary for your clinician. It does not diagnose or give treatment advice.';

  @override
  String get s5ActNotice =>
      'نحفظ إجاباتك حتى تتمكن من مشاركتها مع مقدم الرعاية الصحية. لم نطابق هذه النسخة من الأسئلة مع طريقة الحساب الرسمية، لذلك لا يعرض التطبيق نتيجة.';

  @override
  String get s5ActSaved => 'تم حفظ إجاباتك.';

  @override
  String get s5ActSubtitle => '5 أسئلة عن آخر 4 أسابيع';

  @override
  String get s5ActTitle => 'استبيان السيطرة على الربو';

  @override
  String get s5AddDetails => 'إضافة تفاصيل';

  @override
  String get s5AddRecord => 'إضافة سجل';

  @override
  String get s5AlertArrive => 'When you arrive somewhere';

  @override
  String get s5AlertArriveHint =>
      'When local conditions are worse where you arrive. Only while the app is open.';

  @override
  String get s5AlertFreshAirHint =>
      'When outdoor air quality, pollen, and flood information all look calm. General information, not medical advice.';

  @override
  String get s5AlertSavedPlaces => 'Saved places';

  @override
  String get s5AlertSavedPlacesHint =>
      'When local conditions get worse at a place you saved.';

  @override
  String get s5AlertWorse => 'When conditions get worse';

  @override
  String get s5AlertWorseHint =>
      'When air quality, pollen, or flood information near you gets worse. The same alert is not repeated within an hour.';

  @override
  String get s5AqiGood => 'جيد';

  @override
  String get s5AqiModerate => 'متوسط';

  @override
  String get s5AqiUsg => 'غير صحي للفئات الحساسة';

  @override
  String get s5AqiUnhealthy => 'غير صحي';

  @override
  String get s5AqiVeryUnhealthy => 'غير صحي جدًا';

  @override
  String get s5AqiHazardous => 'خطر';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category (AQI $aqi)';
  }

  @override
  String get s5Back => 'رجوع';

  @override
  String get s5BarrierCost => 'Cost of medicine';

  @override
  String get s5BarrierHardToGet => 'Hard to get medicine';

  @override
  String get s5BarrierHardToUnderstand => 'Hard to understand instructions';

  @override
  String get s5BarrierHowToUse => 'How to use my medicine';

  @override
  String get s5BarrierNone => 'No difficulties';

  @override
  String get s5BarrierOtherHint => 'Describe in your own words (optional)';

  @override
  String get s5Cancel => 'إلغاء';

  @override
  String get s5Change => 'تغيير';

  @override
  String get s5ChoosePlace => 'Choose a place';

  @override
  String get s5Close => 'Close';

  @override
  String get s5DataSourcesTitle => 'Data sources';

  @override
  String get s5DataSourcesBody =>
      'Air quality: U.S. EPA AirNow, Open-Meteo, and nearby PurpleAir sensors.\nPollen: Google Pollen API (Universal Pollen Index).\nWeather and humidity: Open-Meteo.\nFlood alerts: U.S. National Weather Service. Stream levels: U.S. Geological Survey.\nTraffic counts (New Jersey only): NJ Department of Transportation.\nValues can be delayed or missing. They describe outdoor conditions, not your health.';

  @override
  String get s5Delete => 'حذف';

  @override
  String get s5DeleteConfirm => 'هل تريد حذف هذا الإدخال؟';

  @override
  String get s5DeleteFailed => 'تعذر الحذف. حاول مرة أخرى.';

  @override
  String get s5Edit => 'تعديل';

  @override
  String get s5EnglishVersion => 'English (for clinician)';

  @override
  String get s5EntryRemoved => 'تمت إزالة الإدخال.';

  @override
  String get s5EnvAirDetail =>
      'مؤشر جودة الهواء من وكالة حماية البيئة الأمريكية، من محطات عامة وأجهزة قريبة. يصف الهواء الخارجي في منطقتك، وليس عادم المرور وحده.';

  @override
  String get s5EnvAirQuality => 'جودة الهواء';

  @override
  String get s5EnvAlertsHeading => 'Environment alerts';

  @override
  String get s5EnvCardTitle => 'Today\'s local environment';

  @override
  String get s5EnvFlood => 'تنبيهات الفيضان';

  @override
  String get s5EnvFloodDetail =>
      'Public alerts from the U.S. National Weather Service.';

  @override
  String get s5EnvForecast => 'Environmental forecast';

  @override
  String get s5EnvHumidity => 'Humidity conditions';

  @override
  String get s5EnvHumidityDetail =>
      'Outdoor weather data. It is not an indoor humidity or mold measurement.';

  @override
  String get s5EnvLoadFailed => 'Couldn\'t load environmental information.';

  @override
  String get s5EnvNeedPlace => 'Choose a place to see your local environment.';

  @override
  String get s5EnvNotAvailable => 'Not available';

  @override
  String get s5EnvOlderNotice => 'This is the last information we checked.';

  @override
  String get s5EnvPollen => 'مؤشر حبوب اللقاح';

  @override
  String get s5EnvPollenDetail =>
      'Universal Pollen Index from Google, from 0 (none) to 5 (very high). A low number does not mean it is safe for everyone.';

  @override
  String get s5EnvSeeDetails => 'See environment details';

  @override
  String get s5EnvUnavailable => 'Environmental data is currently unavailable.';

  @override
  String get s5FewRecordsNotice =>
      'Some sections may be empty because few records are available.';

  @override
  String get s5FgRefreshTitle => 'Refresh environment while using the app';

  @override
  String get s5FgRefreshHint =>
      'Checks your area while the app is open. It does not run in the background.';

  @override
  String get s5FieldDate => 'التاريخ';

  @override
  String get s5FieldMedication => 'الدواء';

  @override
  String get s5FieldNote => 'ملاحظة (اختياري)';

  @override
  String get s5FieldPuffs => 'عدد البخات (اختياري)';

  @override
  String get s5FieldReason => 'السبب (اختياري)';

  @override
  String get s5FieldTime => 'الوقت';

  @override
  String get s5FilterAll => 'الكل';

  @override
  String get s5FilterInhaler => 'البخاخ';

  @override
  String get s5FilterMedCheck => 'متابعة الدواء';

  @override
  String get s5FilterSymptoms => 'الأعراض';

  @override
  String get s5FloodIssued => 'صدر تنبيه فيضان';

  @override
  String get s5FloodNone => 'لا يوجد تنبيه فيضان';

  @override
  String get s5FloodUnknown => 'Can\'t check alert information';

  @override
  String s5ForecastCheckedAt(String time) {
    return 'Checked $time';
  }

  @override
  String s5ForecastValidFor(String date) {
    return 'Forecast for $date';
  }

  @override
  String get s5FromUrgentHelp => 'سُجل من المساعدة العاجلة';

  @override
  String get s5HomeStateEmpty =>
      'Make your first record. You can organize what to share at your visit along the way.';

  @override
  String s5HomeStateQuestions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'You have $n questions for your doctor.',
      one: 'You have 1 question for your doctor.',
    );
    return '$_temp0';
  }

  @override
  String s5HomeStateRecords(int n) {
    return 'Days with records in the last 7 days: $n';
  }

  @override
  String get s5HomeSubtitle => 'Bring your records to your next visit.';

  @override
  String get s5HomeTitle => 'Record how you\'re doing today';

  @override
  String s5HumidityValue(int rh) {
    return 'Outdoor humidity $rh%';
  }

  @override
  String get s5IncludeEnvironment => 'Local environment (optional)';

  @override
  String get s5IncludeEnvironmentHint =>
      'Adds today\'s air quality, pollen, and flood alerts. Your exact location is not included.';

  @override
  String get s5InhalerEditTitle => 'تفاصيل استخدام البخاخ';

  @override
  String get s5InhalerEntry => 'استخدام البخاخ';

  @override
  String get s5InhalerLogged => 'تم تسجيل استخدام البخاخ.';

  @override
  String get s5InhalerOneEntryHint =>
      'كل حفظ هو إدخال واحد لاستخدام البخاخ. لا يُحسب كبخة واحدة أو كيوم واحد.';

  @override
  String s5InhalerUnknownCount(int n) {
    return 'دواء غير محدد: $n';
  }

  @override
  String get s5InsCost => 'Cost difficulties';

  @override
  String get s5InsDenial => 'Reason given for a denial, if any';

  @override
  String get s5InsMedHistory => 'Medicines I have tried';

  @override
  String get s5InsuranceIntro =>
      'Organize information for your clinician\'s paperwork.';

  @override
  String get s5InsuranceLimits =>
      'Everything here is optional. This app does not submit anything to insurers and does not decide approvals.';

  @override
  String get s5InsuranceTitle => 'Prepare insurance paperwork';

  @override
  String s5LanguageName(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'ko': 'Korean',
      'ja': 'Japanese',
      'zh': 'Chinese',
      'other': 'another language',
    });
    return '$_temp0';
  }

  @override
  String get s5Last30Days => 'آخر 30 يوما';

  @override
  String get s5Last7Days => 'آخر 7 أيام';

  @override
  String get s5LogInhaler => 'تسجيل استخدام البخاخ';

  @override
  String get s5LogLegend =>
      'كل سطر هو إدخال محفوظ. الأيام التي لا توجد فيها إدخالات تظهر “غير مسجلة”، وهذا يختلف عن صفر.';

  @override
  String get s5LogSymptoms => 'تسجيل الأعراض';

  @override
  String get s5MedAdd => 'إضافة دواء';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'أيام الاستخدام: $a · أيام عدم الاستخدام: $b · لا أتذكر: $c · غير مسجلة: $d';
  }

  @override
  String get s5MedCheckIntro =>
      'تسجيل تكتبه أنت: هل استخدمت دواءك. لا يعتمد على سجلات الصيدلية.';

  @override
  String get s5MedCheckQuestion => 'هل استخدمت دواءك كما هو مخطط؟';

  @override
  String get s5MedCheckTitle => 'متابعة دواء اليوم';

  @override
  String get s5MedChooseHint => 'اختر دواء، أو “لا أعرف اسم الدواء”.';

  @override
  String get s5MedDailyCheck => 'متابعة يومية';

  @override
  String get s5MedDailyCheckHint =>
      'اعرض “متابعة دواء اليوم” في الرئيسية. فعّلها فقط إذا طلب منك مقدم الرعاية الصحية استخدام هذا الدواء كل يوم.';

  @override
  String get s5MedDefault => 'الافتراضي للتسجيل السريع';

  @override
  String get s5MedDefaultHint =>
      'يُستخدم عند الضغط على “تسجيل استخدام البخاخ” في الرئيسية.';

  @override
  String get s5MedEdit => 'تعديل الدواء';

  @override
  String get s5MedNameLabel => 'اسم الدواء (كما هو على الملصق)';

  @override
  String get s5MedNotApplicable => 'غير مجدول لهذا اليوم';

  @override
  String s5MedNotApplicableDays(int n) {
    return 'أيام غير مجدولة: $n';
  }

  @override
  String get s5MedNotRecorded => 'الدواء غير مسجل';

  @override
  String get s5MedNotSure => 'لا أتذكر';

  @override
  String get s5MedNotUsed => 'لم أستخدمه';

  @override
  String get s5MedOther => 'اسم آخر';

  @override
  String get s5MedOtherHint => 'اكتب اسم الدواء';

  @override
  String get s5MedReasonCost => 'التكلفة';

  @override
  String get s5MedReasonForgot => 'نسيت';

  @override
  String get s5MedReasonNoMedicine => 'لم يكن الدواء متوفرا لدي';

  @override
  String get s5MedReasonQuestion => 'السبب (اختياري)';

  @override
  String get s5MedUnknown => 'لا أعرف اسم الدواء';

  @override
  String get s5MedUnknownShort => 'دواء غير محدد';

  @override
  String get s5MedUsed => 'استخدمته';

  @override
  String get s5MyLanguage => 'My language';

  @override
  String get s5MyLogTitle => 'سجلي';

  @override
  String get s5MyMedsEmpty => 'لا توجد أدوية محفوظة بعد.';

  @override
  String get s5MyMedsHint =>
      'أسماء أكدتها، لتسريع التسجيل. وهذه ليست توصية بجرعة.';

  @override
  String get s5MyMedsOpen => 'Manage my medications';

  @override
  String get s5MyMedsTitle => 'My medications';

  @override
  String get s5NavEnvironment => 'Environment';

  @override
  String get s5NavLog => 'Log';

  @override
  String get s5NavVisitPrep => 'Visit prep';

  @override
  String get s5NoAnswer => 'أفضل عدم الإجابة';

  @override
  String get s5NoRecordsYet => 'لا توجد سجلات بعد';

  @override
  String s5NoSymptomDays(int n) {
    return 'أيام وُضعت عليها علامة “بلا أعراض”: $n';
  }

  @override
  String get s5NotRecorded => 'غير مسجل';

  @override
  String get s5NotRecordedToday => 'Not recorded today';

  @override
  String s5NotTranslatedLine(String language, String text) {
    return '[Not translated · original in $language] $text';
  }

  @override
  String get s5OsNotificationsOff =>
      'Notifications are turned off for Howse Asthma in your phone settings, so alerts can\'t appear.';

  @override
  String get s5PdfAboutMedCheck =>
      'Medication check-ins are self-reported by the patient. They are not pharmacy refill data and are not a proportion of days covered (PDC).';

  @override
  String get s5PdfAboutNoScore =>
      'No questionnaire score or app-generated risk score is included.';

  @override
  String get s5PdfAboutPatientReported =>
      'All entries were recorded by the patient in the Howse Asthma app and have not been verified.';

  @override
  String get s5PdfAppendix => 'Appendix: patient notes';

  @override
  String s5PdfDaysNotRecorded(int n) {
    return 'Days with no symptom entry (not recorded): $n';
  }

  @override
  String get s5PdfDisclaimer =>
      'This summary contains patient-reported information for clinician review. It is not a diagnosis or a prior authorization decision.';

  @override
  String get s5PdfEnvNote =>
      'General outdoor conditions when this summary was created. Location is not included.';

  @override
  String get s5PdfFailed =>
      'Couldn\'t create the PDF. Your entries are kept. Please try again.';

  @override
  String get s5PdfFontFailed =>
      'Couldn\'t prepare the PDF fonts. Check your internet connection and try again.';

  @override
  String s5PdfGeneratedAt(String time) {
    return 'Created: $time';
  }

  @override
  String s5PdfInhalerByMed(String name, int n) {
    return '$name: $n entries';
  }

  @override
  String s5PdfInhalerMedNotRecorded(int n) {
    return 'Medication not recorded: $n entries';
  }

  @override
  String s5PdfInhalerUnknown(int n) {
    return 'Medication not identified by patient: $n entries';
  }

  @override
  String s5PdfInhalerUses(int n, int days) {
    return 'Inhaler use entries: $n (on $days days)';
  }

  @override
  String get s5PdfIsEnglish =>
      'The PDF is created in English. Free text you typed stays in your language.';

  @override
  String get s5PdfMedNamesAsEntered =>
      'Medication names are shown as entered by the patient.';

  @override
  String get s5PdfNotRecorded => 'Not recorded';

  @override
  String s5PdfNotUsedReason(String label, int n) {
    return 'Reason for not using (self-reported) — $label: $n days';
  }

  @override
  String get s5PdfOutdated =>
      'Your records or answers changed after the last PDF. Create a new PDF to include the changes.';

  @override
  String s5PdfPeriod(String start, String end, int days) {
    return 'Summary period: $start – $end ($days days)';
  }

  @override
  String s5PdfReasonCount(String label, int n) {
    return 'Reason — $label: $n entries';
  }

  @override
  String s5PdfRecordedDays(int n) {
    return 'Days with any patient entry: $n';
  }

  @override
  String get s5PdfSectionAboutData => 'About this information';

  @override
  String get s5PdfSectionBarriers =>
      'Difficulties getting care (self-reported)';

  @override
  String get s5PdfSectionEnvironment => 'Local environment (reference)';

  @override
  String get s5PdfSectionInhaler => 'Inhaler use';

  @override
  String get s5PdfSectionInsurance => 'Notes for paperwork (patient-provided)';

  @override
  String get s5PdfSectionMedChecks => 'Self-reported medication use';

  @override
  String get s5PdfSectionQuestions => 'Patient questions';

  @override
  String get s5PdfSectionSymptoms => 'Symptoms';

  @override
  String s5PdfSymptomCodeDays(String label, int n) {
    return '$label: $n days';
  }

  @override
  String s5PdfSymptomDays(int n, int days) {
    return 'Days with any symptom: $n of $days';
  }

  @override
  String s5PdfSymptomOtherDays(int n) {
    return 'Other symptoms described by patient: $n days';
  }

  @override
  String get s5PdfTitle => 'Patient-reported asthma visit summary';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return 'عدد أيام الفترة: $days · أيام فيها سجلات: $n';
  }

  @override
  String get s5PhoneHint =>
      'Include the country code. Example: +1 201 555 0123';

  @override
  String get s5PhoneInvalid =>
      'Enter a name and a phone number with the country code, for example +1 201 555 0123.';

  @override
  String get s5PollenGrass => 'Grass';

  @override
  String s5PollenMainType(String type) {
    return 'Main type: $type';
  }

  @override
  String get s5PollenTree => 'Tree';

  @override
  String get s5PollenWeed => 'Weed';

  @override
  String get s5PrepareVisit => 'Prepare for visit';

  @override
  String get s5PreviewEditHint =>
      'To change a question or note, go back and edit it. To change numbers, edit the entries in My log.';

  @override
  String get s5PreviewSummary => 'Preview visit summary';

  @override
  String get s5PreviewTitle => 'Visit summary preview';

  @override
  String s5PuffsValue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n بخة',
      many: '$n بخة',
      few: '$n بخات',
      two: 'بختان',
      one: 'بخة واحدة',
      zero: '$n بخات',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return 'السؤال $n من $total';
  }

  @override
  String get s5ReasonBeforeActivity => 'قبل النشاط';

  @override
  String get s5ReasonOther => 'أخرى';

  @override
  String get s5ReasonSymptoms => 'بسبب الأعراض';

  @override
  String s5RecentInhaler(int n) {
    return 'عدد إدخالات استخدام البخاخ: $n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return 'أيام فيها أعراض: $n';
  }

  @override
  String get s5RecentTitle => 'Last 7 days';

  @override
  String get s5RecordsLoadFailed => 'تعذر تحميل سجلاتك. حاول مرة أخرى.';

  @override
  String get s5RecordsManageHint =>
      'You can edit or delete entries in My log. Deleting always asks you to confirm.';

  @override
  String get s5Refresh => 'Refresh';

  @override
  String get s5Reload => 'Load again';

  @override
  String get s5Save => 'حفظ';

  @override
  String get s5Saved => 'تم الحفظ.';

  @override
  String get s5SavedPlacesHint => 'Saved places such as home, school, or work';

  @override
  String get s5SaveFailed => 'تعذر الحفظ. إدخالاتك ما زالت هنا.';

  @override
  String get s5SavePdf => 'Save PDF';

  @override
  String get s5SettingsAlerts => 'Alerts';

  @override
  String get s5SettingsArea => 'Area';

  @override
  String get s5SettingsHelp => 'Help';

  @override
  String get s5SettingsLanguageNote =>
      'Your visit summary is created in English. You can compare it with your own language before sharing.';

  @override
  String get s5SettingsSecurityData => 'Security and data';

  @override
  String get s5Share => 'Share';

  @override
  String get s5SourcesAir => 'Air quality: EPA AirNow, Open-Meteo, PurpleAir';

  @override
  String get s5SourcesFlood => 'Flood alerts: National Weather Service';

  @override
  String get s5SourcesNjTraffic =>
      'Traffic count data is used only in New Jersey.';

  @override
  String get s5SourcesNoRiskScore =>
      'The app\'s internal combined score is not an asthma attack risk and is not shown.';

  @override
  String get s5SourcesPollen => 'Pollen: Google Pollen API';

  @override
  String get s5SourcesTitle => 'Sources and limits';

  @override
  String get s5SourcesWeather => 'Weather and humidity: Open-Meteo';

  @override
  String get s5StatusLatest => 'Latest';

  @override
  String get s5StatusOlder => 'Older data';

  @override
  String get s5StatusUnavailable => 'Can\'t check right now';

  @override
  String get s5SymActivityLimited => 'نشاط محدود';

  @override
  String get s5SymCough => 'سعال';

  @override
  String get s5SymNightWaking => 'استيقظت في الليل';

  @override
  String get s5SymNone => 'بلا أعراض';

  @override
  String get s5SymOther => 'شيء آخر';

  @override
  String get s5SymOtherHint => 'صف بكلماتك';

  @override
  String get s5SymShortBreath => 'صعوبة في التنفس';

  @override
  String get s5SymWheeze => 'أزيز في الصدر';

  @override
  String get s5SymptomEditTitle => 'تعديل الأعراض';

  @override
  String get s5SymptomEntry => 'الأعراض';

  @override
  String get s5SymptomNoneHint =>
      'الأيام التي لا تسجلها تظهر “غير مسجلة”، وليست “بلا أعراض”.';

  @override
  String get s5SymptomQuestion => 'ماذا لاحظت؟';

  @override
  String get s5Today => 'اليوم';

  @override
  String get s5Undo => 'تراجع';

  @override
  String s5UntranslatedNotice(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n entries are not translated. They appear in the English PDF in your language, marked “Not translated”.',
      one:
          '1 entry is not translated. It appears in the English PDF in your language, marked “Not translated”.',
    );
    return '$_temp0';
  }

  @override
  String s5UpdatedAt(String time) {
    return 'Updated $time';
  }

  @override
  String get s5UpiHigh => 'High';

  @override
  String get s5UpiLow => 'Low';

  @override
  String get s5UpiModerate => 'Moderate';

  @override
  String get s5UpiNone => 'None';

  @override
  String s5UpiValue(int upi, String category) {
    return '$upi of 5 · $category';
  }

  @override
  String get s5UpiVeryHigh => 'Very high';

  @override
  String get s5UpiVeryLow => 'Very low';

  @override
  String get s5UrgentActionPlan =>
      'إذا أعطاك مقدم الرعاية الصحية خطة عمل للربو، فاتبعها.';

  @override
  String get s5UrgentCall911Locked => 'Urgent help: call 911';

  @override
  String get s5UrgentHelp => 'مساعدة عاجلة';

  @override
  String get s5UrgentIntro =>
      'إذا كان التنفس صعبا جدا أو لا يتحسن، اتصل بالرقم 911.';

  @override
  String get s5UrgentLogHint => 'اختياري: احفظ سجلا بأنك استخدمت بخاخك.';

  @override
  String get s5UrgentNoContact =>
      'لا توجد جهة اتصال للطوارئ بعد. أضف واحدة من الإعدادات ← المساعدة.';

  @override
  String s5UsingMedication(String name) {
    return 'Logs as: $name';
  }

  @override
  String get s5ViewMyLog => 'View my log';

  @override
  String get s5VisitBarriers => 'Did you have trouble getting care?';

  @override
  String s5VisitCardDetail(int days, int recorded, int questions) {
    return 'Last $days days · Days with records: $recorded · Questions: $questions';
  }

  @override
  String get s5VisitCardTitle => 'What to share at your visit';

  @override
  String get s5VisitInclude => 'Records to include';

  @override
  String get s5VisitIntro =>
      'Organize your symptoms and questions to show your clinician.';

  @override
  String get s5VisitPeriod => 'Summary period';

  @override
  String get s5VisitPrepTitle => 'Visit prep';

  @override
  String get s5VisitQuestions => 'Questions for your doctor';

  @override
  String get s5VisitQuestionsHint =>
      'Write in your own language. You can leave these empty.';

  @override
  String get s6AddTime => 'إضافة وقت';

  @override
  String get s6AddVisit => 'Add a visit I reported';

  @override
  String get s6BringPaper => 'I will bring a paper';

  @override
  String get s6BringPaperHint =>
      'Bringing a paper does not mean a clinician has confirmed it.';

  @override
  String s6DaySummary(
    String date,
    int used,
    int scheduled,
    int open,
    int symptoms,
    String env,
  ) {
    return '$date · confirmed $used/$scheduled · unconfirmed $open · symptoms $symptoms · $env';
  }

  @override
  String get s6DoseLater => 'تحقق لاحقا';

  @override
  String get s6DoseNotUsed => 'لم أتمكن من استخدامه';

  @override
  String get s6DoseUnconfirmed => 'No answer yet';

  @override
  String get s6DoseUsed => 'استخدمته';

  @override
  String get s6EnvLinked => 'Environment linked';

  @override
  String get s6EnvNoData => 'No environment data for that time';

  @override
  String get s6EvidenceBody =>
      'Organizes records for your clinician and what still needs to be added.';

  @override
  String get s6EvidenceNotOfficial =>
      'This is a general list. It is not an official list of requirements from a specific insurance plan.';

  @override
  String get s6EvidenceTitle =>
      'Prepare records for a visit or insurance review';

  @override
  String get s6HideMedName => 'Hide the medicine name on the lock screen';

  @override
  String get s6HideMedNameHint =>
      'The reminder still arrives at the times you saved. It is not a repeating background alert.';

  @override
  String get s6HomeWaterNo => 'لا';

  @override
  String get s6HomeWaterQuestion => 'هل حدث تسرب مياه أو فيضان في المنزل؟';

  @override
  String get s6HomeWaterYes => 'نعم';

  @override
  String get s6ItemClinician => 'Clinician confirmation or papers to bring';

  @override
  String get s6ItemEnvironment =>
      'Local environment reference at the time of an event';

  @override
  String get s6ItemMedication => 'Medicine name and prescription';

  @override
  String get s6ItemSymptoms => 'Ongoing symptoms and limits on daily life';

  @override
  String get s6ItemUse => 'Time period and use you confirmed';

  @override
  String get s6ItemVisits => 'Visits and emergency visits you reported';

  @override
  String get s6NoSchedule =>
      'No saved dose times yet. Add them under My medications.';

  @override
  String get s6OccurredLabel => 'وقت الحدوث';

  @override
  String get s6PdfEnvLimit =>
      'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.';

  @override
  String get s6PdfEnvTitle => 'Environment reference (appendix)';

  @override
  String get s6PuffsEach => 'عدد البخات في كل مرة';

  @override
  String s6ReminderBodyNamed(String name) {
    return 'حان وقت تأكيد $name';
  }

  @override
  String get s6ReminderBodyPrivate => 'حان وقت تأكيد دوائك';

  @override
  String get s6ReminderChannel =>
      'تذكيرات في أوقات الجرعات التي حفظتها. هذا ليس تنبيه الهواء والطقس كل 30 دقيقة.';

  @override
  String get s6ReminderTitle => 'متابعة الدواء';

  @override
  String get s6RoleBoth => 'يوميا وعند الحاجة';

  @override
  String get s6RoleController => 'دواء يومي';

  @override
  String get s6RoleRescue => 'عند الحاجة';

  @override
  String get s6ScheduleTimes => 'أوقات تناوله';

  @override
  String get s6StatusClinician => 'Clinician confirmation needed';

  @override
  String get s6StatusNeedInfo => 'More information needed';

  @override
  String get s6StatusRecorded => 'Recorded';

  @override
  String get s6TimelineTitle => 'Treatment and environment';

  @override
  String get s6TodayDoses => 'Medicines to confirm today';

  @override
  String get s6VisitKindEr => 'Emergency room (I reported this)';

  @override
  String get s6VisitKindOffice => 'Clinic visit (I reported this)';

  @override
  String get s6VisitKindOther => 'Other visit (I reported this)';

  @override
  String get s6VisitKindUrgent => 'Urgent care (I reported this)';

  @override
  String get v2SettingsTitle => 'Coverage letters';

  @override
  String get v2NavToggle => 'Show coverage-letter home';

  @override
  String get v2NavToggleHint =>
      'A preview for reading a denial notice and preparing visit materials. Your records stay available. Live document reading stays off.';

  @override
  String get v2HomeHeadline =>
      'Understand a coverage denial letter and prepare materials for a visit.';

  @override
  String get v2HomeBody =>
      'The app does not send an appeal and does not decide whether a plan will approve it.';

  @override
  String get v2AddLetter => 'Add a denial letter';

  @override
  String get v2TrySample => 'Try a sample';

  @override
  String get v2SampleBanner =>
      'Sample. Not a real notice and not a live reading.';

  @override
  String get v2LiveOffTitle => 'Live reading is off';

  @override
  String get v2LiveOffBody =>
      'Photos and files are not analyzed in this build. You can open the labeled sample and walk through the steps.';

  @override
  String get v2Close => 'Close';

  @override
  String get v2MyRecords => 'My records';

  @override
  String get v2EmptyCases => 'No letters yet.';

  @override
  String get v2MedNeedsReview => 'Medication needs review';

  @override
  String get v2NextCheck => 'Next: review the facts';

  @override
  String get v2NextDraft => 'Next: make a draft';

  @override
  String get v2Created => 'Added';

  @override
  String get v2StatusDraft => 'Draft ready';

  @override
  String get v2StatusReady => 'Ready for a draft';

  @override
  String get v2StatusReview => 'Needs review';

  @override
  String get v2DeadlineLabel => 'Deadline';

  @override
  String get v2ExplainTitle => 'Plain explanation';

  @override
  String get v2CheckTitle => 'Things to check';

  @override
  String get v2RecordsTitle => 'My records';

  @override
  String get v2DocsTitle => 'Make documents';

  @override
  String get v2Original => 'Original text';

  @override
  String get v2Patient => 'Name on the notice';

  @override
  String get v2EditMedication => 'Medication text';

  @override
  String get v2Dose => 'Dose as written';

  @override
  String get v2ReasonMissing => 'The reason could not be confirmed.';

  @override
  String get v2ConfirmDate => 'I confirm the date printed on the notice';

  @override
  String get v2SaveEdit => 'Save correction';

  @override
  String get v2ConfirmFacts => 'I reviewed these facts';

  @override
  String get v2Confirmed => 'Reviewed';

  @override
  String get v2NoRecords =>
      'No records linked. You can still make a draft. No adherence figure is added.';

  @override
  String get v2SelfReportLabel => 'Optional note (patient self-report)';

  @override
  String get v2EnglishDraft =>
      'English draft for review. This is the draft to check, not a filed translation.';

  @override
  String get v2DraftBannerNote =>
      'Every page says clinician review is required.';

  @override
  String get v2StaleDraft =>
      'Facts changed. Make the draft again before sharing.';

  @override
  String get v2GenerateReview => 'Make a review draft';

  @override
  String get v2GeneratePrepared => 'Make a prepared draft';

  @override
  String get v2PreparedBlocked =>
      'A prepared draft needs a confirmed name, medication, and denial reason.';

  @override
  String get v2NotInitial =>
      'This document is not an initial drug denial. An appeal draft is not created.';

  @override
  String get v2GenericError => 'That step did not finish. You can try again.';

  @override
  String get v2Share => 'Share';

  @override
  String get v2ClinicianPdf => 'Clinician one-page PDF';

  @override
  String get v2ShareNotSubmitted =>
      'Sharing does not mean the plan received this file.';

  @override
  String get v2DeleteCase => 'Delete this sample';

  @override
  String get v2Deleted => 'Removed from this preview.';

  @override
  String get v2FontUnavailable =>
      'The PDF font could not be loaded. Try again when you are online.';

  @override
  String get v2NotEntered => '[not entered]';

  @override
  String get v2DocDeadline => 'Deadline written on the document';

  @override
  String get v2CalcDeadline => 'Calculated from the received date you entered';

  @override
  String get v2NeedReceived =>
      'The notice counts days after you receive it. Enter that date before a date can be calculated.';

  @override
  String get v2UnclearDeadline =>
      'The deadline wording is unclear. No date was calculated.';

  @override
  String get v2AskPlan =>
      'A deadline was not found in the document. Ask the plan.';

  @override
  String get cnTagline => 'رسائل التأمين، وخطوات تالية واضحة';

  @override
  String get cnDemoBadge => 'نموذج';

  @override
  String get cnDemoBadgeLong => 'نموذج ببيانات وهمية. النتائج ثابتة.';

  @override
  String get cnAuthSignInTitle => 'تسجيل الدخول';

  @override
  String get cnAuthCreateTitle => 'إنشاء حساب';

  @override
  String get cnAuthResetTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get cnAuthSignIn => 'تسجيل الدخول';

  @override
  String get cnAuthCreate => 'إنشاء حساب';

  @override
  String get cnAuthSendReset => 'إرسال رابط إعادة التعيين';

  @override
  String cnAuthProfileError(String code) {
    return 'تم تسجيل دخولك، لكن تعذر تحميل حسابك ($code).';
  }

  @override
  String get cnRetry => 'حاول مرة أخرى';

  @override
  String get cnSignOut => 'تسجيل الخروج';

  @override
  String get cnAuthPreparingAccount => 'جارٍ إعداد حسابك…';

  @override
  String get cnAuthNameLabel => 'الاسم (اختياري)';

  @override
  String get cnAuthNameHelper => 'يظهر على حزم مستنداتك. يمكنك تغييره لاحقا.';

  @override
  String get cnAuthEmailLabel => 'البريد الإلكتروني';

  @override
  String get cnAuthPasswordLabel => 'كلمة المرور';

  @override
  String get cnAuthPasswordHelper => '8 أحرف على الأقل';

  @override
  String get cnAuthShowPassword => 'إظهار كلمة المرور';

  @override
  String get cnAuthHidePassword => 'إخفاء كلمة المرور';

  @override
  String get cnAuthPasswordRequired => 'أدخل كلمة المرور';

  @override
  String cnAuthCheckEmail(String email) {
    return 'أرسلنا رابط تأكيد إلى $email. افتحه على هذا الهاتف، ثم سجل الدخول.';
  }

  @override
  String cnAuthResetSent(String email) {
    return 'إذا كان هناك حساب لـ $email، فسيصلك رابط إعادة التعيين. افتحه على هذا الهاتف.';
  }

  @override
  String get cnAuthResent => 'تم الإرسال مرة أخرى.';

  @override
  String get cnAuthResend => 'إعادة إرسال البريد';

  @override
  String get cnAuthSignInInstead => 'أكدت بريدي. تسجيل الدخول';

  @override
  String get cnAuthForgot => 'نسيت كلمة المرور؟';

  @override
  String get cnAuthNoAccount => 'جديد هنا؟ أنشئ حسابا';

  @override
  String get cnAuthHaveAccount => 'لديك حساب؟ سجل الدخول';

  @override
  String get cnAuthResetHint =>
      'أدخل بريدك الإلكتروني وسنرسل لك رابطا لتعيين كلمة مرور جديدة.';

  @override
  String get cnAuthBackToSignIn => 'العودة إلى تسجيل الدخول';

  @override
  String get cnAuthPrivacyLine => 'رسائلك وسجلاتك خاصة بحسابك.';

  @override
  String get cnAuthPasswordUpdated => 'تم تحديث كلمة المرور.';

  @override
  String get cnAuthNewPasswordTitle => 'تعيين كلمة مرور جديدة';

  @override
  String get cnAuthNewPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get cnAuthSavePassword => 'حفظ كلمة المرور';

  @override
  String get cnLater => 'لاحقا';

  @override
  String get cnAuthErrInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get cnAuthErrNotConfirmed =>
      'يرجى تأكيد بريدك الإلكتروني أولا. تحقق من صندوق الوارد أو أعد إرسال الرابط.';

  @override
  String get cnAuthErrExists =>
      'يوجد حساب بهذا البريد الإلكتروني بالفعل. سجل الدخول بدلا من ذلك.';

  @override
  String get cnAuthErrWeakPassword => 'اختر كلمة مرور أقوى (8 أحرف على الأقل).';

  @override
  String get cnAuthErrSamePassword => 'استخدم كلمة مرور مختلفة عن القديمة.';

  @override
  String get cnAuthErrRateLimited =>
      'محاولات كثيرة. انتظر دقيقة ثم حاول مرة أخرى.';

  @override
  String get cnAuthErrInvalidEmail => 'تحقق من عنوان البريد الإلكتروني.';

  @override
  String get cnAuthErrEmailNotAuthorized =>
      'تعذر إرسال بريد إلى هذا العنوان الآن. حاول لاحقا.';

  @override
  String get cnAuthErrDisabled => 'طريقة تسجيل الدخول هذه متوقفة.';

  @override
  String get cnAuthErrSessionExpired =>
      'انتهت جلستك. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String cnAuthErrUnknown(String code) {
    return 'حدث خطأ ما ($code). حاول مرة أخرى.';
  }

  @override
  String get cnErrNetwork => 'لا يوجد اتصال. تحقق من الإنترنت وحاول مرة أخرى.';

  @override
  String get cnErrServiceDown =>
      'الخدمة لا تستجيب. حاول مرة أخرى بعد بضع دقائق.';

  @override
  String get cnTabHome => 'الرئيسية';

  @override
  String get cnTabCases => 'الملفات';

  @override
  String get cnTabRecords => 'السجلات';

  @override
  String get cnTabAccount => 'الحساب';

  @override
  String get cnHomeHeadline => 'افهم رسالة التأمين الخاصة بك.';

  @override
  String get cnScanLetter => 'امسح رسالة ضوئيا';

  @override
  String get cnUploadFile => 'رفع PDF / صورة';

  @override
  String get cnTryDemo => 'جرّب العرض التجريبي';

  @override
  String get cnHomeSignInLine => 'حفظ ملفاتك يحتاج إلى حساب.';

  @override
  String get cnServiceNotConfigured =>
      'هذه النسخة غير متصلة بالخادم. يعمل العرض التجريبي فقط.';

  @override
  String get cnContinueCase => 'تابع ملفك';

  @override
  String get cnHowItWorks => 'كيف يعمل';

  @override
  String get cnStep1Title => 'قراءة الرسالة';

  @override
  String get cnStep1Body => 'التقط صورة. نجد السبب والخطوة التالية والتاريخ.';

  @override
  String get cnStep2Title => 'جمع السجلات';

  @override
  String get cnStep2Body => 'طابق ما تطلبه الرسالة مع سجلاتك الخاصة.';

  @override
  String get cnStep3Title => 'إنشاء حزمة المستندات';

  @override
  String get cnStep3Body =>
      'احصل على ملخص من صفحة واحدة للطبيب ومسودة طلب مراجعة.';

  @override
  String get cnRecentCases => 'ملفات أخرى';

  @override
  String get cnNoCasesYet => 'لا توجد ملفات بعد';

  @override
  String get cnNoOtherCases => 'لا توجد ملفات أخرى.';

  @override
  String get cnSeeAllCases => 'عرض كل الملفات';

  @override
  String get cnNoCasesBody => 'امسح رسالة تأمين ضوئيا للبدء.';

  @override
  String get cnCasesSignInTitle => 'سجل الدخول لرؤية ملفاتك';

  @override
  String get cnCasesSignInBody => 'أو افتح العرض التجريبي لترى كيف يعمل.';

  @override
  String get cnCaseDeleted => 'تم حذف الملف.';

  @override
  String get cnCaseUntitled => 'رسالة تأمين';

  @override
  String get cnStatusReading => 'جارٍ قراءة الرسالة';

  @override
  String get cnStatusNeedsReview => 'يحتاج إلى مراجعة';

  @override
  String get cnStatusGatherRecords => 'جمع السجلات';

  @override
  String get cnStatusPacketReady => 'حزمة المستندات جاهزة';

  @override
  String get cnStatusNeedsAttention => 'يحتاج إلى انتباه';

  @override
  String get cnStatusNotStarted => 'لم يبدأ';

  @override
  String get cnNextWaitReading => 'نحن نقرأ الرسالة.';

  @override
  String get cnNextTryAgain => 'توقفت القراءة. افتح الملف لإعادة المحاولة.';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count معلومة للتأكد منها',
      many: '$count معلومة للتأكد منها',
      few: '$count معلومات للتأكد منها',
      two: 'معلومتان للتأكد منهما',
      one: 'معلومة واحدة للتأكد منها',
      zero: '$count معلومات للتأكد منها',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return 'تم التعامل مع $done من $total من العناصر المطلوبة';
  }

  @override
  String get cnNextSharePacket => 'حزمة المستندات جاهزة للمشاركة';

  @override
  String get cnNextCreatePacket => 'التالي: إنشاء حزمة المستندات';

  @override
  String cnDateToCheckShort(String date) {
    return 'تاريخ للتحقق منه: $date';
  }

  @override
  String cnDatePassedShort(String date) {
    return 'انقضى التاريخ: $date';
  }

  @override
  String get cnMoreActions => 'مزيد من الإجراءات';

  @override
  String get cnDeleteCase => 'حذف الملف';

  @override
  String get cnDeleteCaseTitle => 'هل تريد حذف هذا الملف؟';

  @override
  String get cnDeleteCaseBody =>
      'يحذف هذا صفحات الرسالة، والمعلومات التي قُرئت منها، وملخصات السجلات المرتبطة، وحزم المستندات. سجلات أدويتك وأعراضك تبقى.';

  @override
  String get cnCancel => 'إلغاء';

  @override
  String get cnDelete => 'حذف';

  @override
  String get cnDeleteFailed => 'تعذر الحذف. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get cnKindInitialDenial => 'رفض تغطية الدواء (Denial)';

  @override
  String get cnKindInfoRequest => 'طلب معلومات إضافية';

  @override
  String get cnKindReauth => 'إشعار تجديد الموافقة (Reauthorization)';

  @override
  String get cnKindFinalDenial =>
      'القرار النهائي للاستئناف (Final appeal decision)';

  @override
  String get cnKindEob => 'فاتورة أو شرح المزايا (Explanation of Benefits)';

  @override
  String get cnKindOther => 'رسالة أخرى';

  @override
  String get cnKindUncertain => 'نوع الرسالة غير واضح';

  @override
  String get cnFieldPatientName => 'اسم المريض';

  @override
  String get cnFieldPlanName => 'خطة التأمين';

  @override
  String get cnFieldMemberId => 'رقم العضوية';

  @override
  String get cnFieldCaseReference => 'رقم الملف أو المرجع';

  @override
  String get cnFieldMedication => 'الدواء (كما هو مكتوب)';

  @override
  String get cnFieldDose => 'الجرعة (كما هي مكتوبة)';

  @override
  String get cnFieldNoticeDate => 'تاريخ الإشعار';

  @override
  String get cnFieldContact => 'جهة الاتصال';

  @override
  String get cnFieldSubmissionRoute => 'أين يُرسل';

  @override
  String get cnFactEdited => 'عدّلته أنت';

  @override
  String get cnFactChecked => 'تم التحقق';

  @override
  String get cnFactNotInLetter => 'غير مذكور في الرسالة';

  @override
  String get cnFactNeedsCheck => 'يحتاج إلى تحقق';

  @override
  String get cnFactFromLetter => 'من الرسالة';

  @override
  String get cnWhoYou => 'أنت';

  @override
  String get cnWhoCareTeam => 'فريق الرعاية';

  @override
  String get cnWhoPlan => 'خطة التأمين';

  @override
  String get cnWhoUnknown => 'غير متأكد';

  @override
  String get cnReqLinked => 'مرتبط';

  @override
  String get cnReqAskedCareTeam => 'طُلب من فريق الرعاية';

  @override
  String get cnReqNotAvailable => 'غير متوفر';

  @override
  String get cnReqNotNeeded => 'غير مطلوب';

  @override
  String get cnReqNeeded => 'مطلوب';

  @override
  String get cnReqReset => 'ضع علامة مطلوب';

  @override
  String get cnRecMedication => 'سجل الأدوية';

  @override
  String get cnRecSymptoms => 'سجل الأعراض';

  @override
  String get cnRecLocalContext => 'عوامل البيئة';

  @override
  String get cnRecPrn => 'بخاخ عند الحاجة';

  @override
  String get cnDemoTitle => 'عرض تجريبي';

  @override
  String get cnDemoReset => 'إعادة ضبط العرض التجريبي';

  @override
  String get cnDemoResetDone => 'تمت إعادة ضبط العرض التجريبي.';

  @override
  String get cnDemoIntro =>
      'ثلاث رسائل وهمية بنتائج ثابتة، لترى كل خطوة. لا يتم رفع أي شيء.';

  @override
  String get cnUpEmpty => 'هذا الملف فارغ.';

  @override
  String cnUpTooLarge(int mb) {
    return 'يجب ألا يزيد حجم كل ملف عن $mb MB.';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return 'يجب ألا يزيد حجم كل الصفحات معا عن $mb MB.';
  }

  @override
  String cnUpTooManyPages(int max) {
    return 'الحد الأقصى لعدد الصفحات لكل رسالة: $max.';
  }

  @override
  String get cnUpUnsupported =>
      'استخدم JPG أو PNG أو PDF. لصور HEIC، التقط صورة جديدة من هنا.';

  @override
  String get cnUpBadFile =>
      'تعذرت قراءة هذا الملف. جرّب صورة أخرى أو ملف PDF آخر.';

  @override
  String get cnUpEncrypted =>
      'ملف PDF هذا محمي بكلمة مرور. احفظ نسخة غير مقفلة أو التقط صورا.';

  @override
  String get cnCameraUnavailable =>
      'الكاميرا غير متاحة. يمكنك رفع صورة أو ملف PDF بدلا من ذلك.';

  @override
  String get cnPhotosUnavailable =>
      'تعذر فتح الصور. اسمح بالوصول إلى الصور من الإعدادات، أو ارفع ملف PDF.';

  @override
  String get cnFilesUnavailable => 'تعذر فتح الملفات الآن. حاول مرة أخرى.';

  @override
  String get cnUploadFailed =>
      'لم يكتمل الرفع. صفحاتك ما زالت هنا. حاول مرة أخرى.';

  @override
  String get cnCaptureTitle => 'إضافة صفحات الرسالة';

  @override
  String get cnReplacePagesTitle => 'استبدال صفحات الرسالة';

  @override
  String get cnOpening => 'جارٍ الفتح…';

  @override
  String get cnCaptureEmptyTitle => 'أضف صفحات رسالتك';

  @override
  String get cnCaptureTips =>
      'ضع الصفحة مسطحة في إضاءة جيدة، وأدخل الزوايا الأربع في الإطار. أضف كل الصفحات بالترتيب.';

  @override
  String get cnTakePhoto => 'التقاط صورة';

  @override
  String get cnAddPage => 'إضافة صفحة';

  @override
  String get cnAddPhoto => 'صورة';

  @override
  String get cnPickGallery => 'اختيار من الصور';

  @override
  String get cnLabelForm => 'الشكل (كما هو مكتوب)';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages صفحة',
      many: '$pages صفحة',
      few: '$pages صفحات',
      two: 'صفحتان',
      one: 'صفحة واحدة',
      zero: '$pages صفحات',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      'يرسل الرفع هذه الصفحات إلى خادم CoverNote، حيث تقرؤها خدمة ذكاء اصطناعي لأجلك. يمكنك حذف الملف في أي وقت.';

  @override
  String get cnStageUploading => 'جارٍ الرفع';

  @override
  String get cnUploadAndRead => 'رفع وقراءة';

  @override
  String cnPageN(int n) {
    return 'صفحة $n';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صفحة',
      many: '$count صفحة',
      few: '$count صفحات',
      two: 'صفحتان',
      one: 'صفحة واحدة',
      zero: '$count صفحات',
    );
    return 'المستند $n · PDF، $_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return 'معاينة الصفحة $n';
  }

  @override
  String get cnRotate => 'تدوير';

  @override
  String get cnRetake => 'إعادة التصوير';

  @override
  String get cnRemovePage => 'إزالة';

  @override
  String get cnReorder => 'اسحب لإعادة الترتيب';

  @override
  String get cnServiceUnavailableBody =>
      'قارئ الرسائل غير مُعدّ الآن. صفحاتك محفوظة؛ حاول لاحقا.';

  @override
  String get cnNeedNewPagesBody =>
      'التقط صورا أوضح أو استخدم صفحات أقل، ثم ارفع مرة أخرى.';

  @override
  String get cnPagesKept => 'صفحاتك محفوظة. لم يتغير شيء.';

  @override
  String get cnReplacePages => 'استبدال الصفحات';

  @override
  String get cnTryAgain => 'حاول مرة أخرى';

  @override
  String get cnStageReading => 'القراءة';

  @override
  String get cnStageChecking => 'التحقق';

  @override
  String get cnStageReady => 'جاهز';

  @override
  String get cnReadingTitle => 'جارٍ قراءة رسالتك';

  @override
  String get cnReadingBody => 'عند الانتهاء، تقارن ما وجدناه بما في الرسالة.';

  @override
  String get cnReadingLeaveOk =>
      'يمكنك مغادرة هذه الشاشة. تستمر القراءة ويُحفظ ملفك.';

  @override
  String get cnStartReading => 'ابدأ القراءة';

  @override
  String get cnStepLetter => 'الرسالة';

  @override
  String get cnStepReview => 'المراجعة';

  @override
  String get cnStepEvidence => 'السجلات';

  @override
  String get cnStepPacket => 'حزمة المستندات';

  @override
  String cnStepOf(int n, int total, String name) {
    return 'الخطوة $n من $total: $name';
  }

  @override
  String get cnSaving => 'جارٍ الحفظ…';

  @override
  String get cnSaved => 'تم الحفظ';

  @override
  String get cnNotSavedRetry => 'لم يتم الحفظ · أعد المحاولة';

  @override
  String get cnViewOriginal => 'عرض الصفحات الأصلية';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تمت قراءة $count صفحة',
      many: 'تمت قراءة $count صفحة',
      few: 'تمت قراءة $count صفحات',
      two: 'تمت قراءة صفحتين',
      one: 'تمت قراءة صفحة واحدة',
      zero: 'تمت قراءة $count صفحات',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return 'صعبة القراءة: الصفحة $list. راجع هذه المعلومات بعناية أو أعد تصوير الصفحة.';
  }

  @override
  String get cnRetakePages => 'إعادة تصوير الصفحات';

  @override
  String get cnHardToRead => 'صعب القراءة';

  @override
  String get cnContinueToReview => 'المتابعة إلى المراجعة';

  @override
  String get cnOriginalPages => 'الصفحات الأصلية';

  @override
  String get cnNoOriginal => 'لا توجد صفحات أصلية محفوظة.';

  @override
  String get cnCheckDetails => 'تحقق من التفاصيل';

  @override
  String get cnCheckDetailsHint =>
      'قارن كل قيمة برسالتك. المس اقتباسا لترى من أين جاء.';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تحقق من $count عنصر آخر للمتابعة',
      many: 'تحقق من $count عنصرا آخر للمتابعة',
      few: 'تحقق من $count عناصر أخرى للمتابعة',
      two: 'تحقق من عنصرين آخرين للمتابعة',
      one: 'تحقق من عنصر واحد آخر للمتابعة',
      zero: 'تحقق من $count عناصر أخرى للمتابعة',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => 'المتابعة إلى السجلات';

  @override
  String cnSeePage(int n) {
    return 'عرض الصفحة $n';
  }

  @override
  String get cnWhatLetterIs => 'نوع هذه الرسالة';

  @override
  String get cnLooksRight => 'يبدو صحيحا';

  @override
  String get cnChange => 'تغيير';

  @override
  String get cnCardWhyDenied => 'سبب الرفض';

  @override
  String get cnCardWhatTheyNeed => 'ما طلبوه';

  @override
  String get cnCardWhatItSays => 'ما تقوله الرسالة';

  @override
  String get cnNoReasonFound => 'لم يُعثر على سبب في الرسالة.';

  @override
  String get cnCardNextStep => 'الخطوة التالية';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'اطلب من فريق الرعاية أن يطلب مراجعة. تذكر الرسالة $count عنصر لإرساله.',
      many:
          'اطلب من فريق الرعاية أن يطلب مراجعة. تذكر الرسالة $count عنصرا لإرساله.',
      few:
          'اطلب من فريق الرعاية أن يطلب مراجعة. تذكر الرسالة $count عناصر لإرسالها.',
      two:
          'اطلب من فريق الرعاية أن يطلب مراجعة. تذكر الرسالة عنصرين لإرسالهما.',
      one:
          'اطلب من فريق الرعاية أن يطلب مراجعة. تذكر الرسالة عنصرا واحدا لإرساله.',
      zero: 'اطلب من فريق الرعاية أن يطلب مراجعة. الرسالة لا تذكر عناصر محددة.',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أرسل $count عنصر طلبته خطة التأمين بحلول التاريخ أدناه.',
      many: 'أرسل $count عنصرا طلبته خطة التأمين بحلول التاريخ أدناه.',
      few: 'أرسل $count عناصر طلبتها خطة التأمين بحلول التاريخ أدناه.',
      two: 'أرسل العنصرين اللذين طلبتهما خطة التأمين بحلول التاريخ أدناه.',
      one: 'أرسل العنصر الواحد الذي طلبته خطة التأمين بحلول التاريخ أدناه.',
      zero: 'أرسل المعلومات التي طلبتها خطة التأمين بحلول التاريخ أدناه.',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth =>
      'دوّن موعد انتهاء الموافقة الحالية، واطلب من فريق الرعاية بدء التجديد.';

  @override
  String get cnNextFinal =>
      'هذا قرار نهائي. لا يكتب CoverNote مسودة طلب مراجعة أول له. اسأل خطة التأمين أو فريق الرعاية عن الخيارات المذكورة في الرسالة.';

  @override
  String get cnNextEob =>
      'تبدو هذه فاتورة أو شرح للمزايا، وليست رفض تغطية. راجعها مع خدمة الأعضاء في خطة التأمين.';

  @override
  String get cnNextUncertain => 'أولا، أكّد نوع هذه الرسالة في الأعلى.';

  @override
  String cnWhereToSend(String route) {
    return 'أين يُرسل: $route';
  }

  @override
  String cnWhoToCall(String contact) {
    return 'جهة الاتصال: $contact';
  }

  @override
  String get cnCardDate => 'تاريخ للتحقق منه';

  @override
  String cnDateCalculated(String anchor, int days) {
    return 'محسوب: $anchor + $days يوما تقويميا';
  }

  @override
  String get cnReceivedDateWord => 'تاريخ استلامك لها';

  @override
  String get cnNoticeDateWord => 'تاريخ الإشعار';

  @override
  String get cnDateEnteredByYou => 'أدخلته أنت';

  @override
  String get cnDateFromLetter => 'مذكور في الرسالة';

  @override
  String cnReceivedOn(String date) {
    return 'استلمتها في $date';
  }

  @override
  String get cnDatePassed =>
      'انقضى هذا التاريخ. اتصل بخطة التأمين واسأل ما الذي ما زال بإمكانك فعله.';

  @override
  String cnNeedReceivedDate(int days) {
    return 'تذكر الرسالة $days يوما تقويميا من يوم استلامك لها. متى وصلتك؟';
  }

  @override
  String get cnEnterReceivedDate => 'أدخل تاريخ الاستلام';

  @override
  String get cnDateConflict =>
      'تذكر الرسالة تواريخ مختلفة. اسأل خطة التأمين أي تاريخ ينطبق، ثم اختره.';

  @override
  String cnUseThisDate(String date) {
    return 'استخدم $date';
  }

  @override
  String get cnDateUnclear =>
      'الصياغة غير واضحة أو تحسب أيام العمل، لذلك لا يحسب CoverNote التاريخ. اسأل خطة التأمين عن التاريخ الدقيق.';

  @override
  String get cnNoDeadline => 'لم يُعثر على موعد نهائي للمراجعة في الرسالة.';

  @override
  String cnReplyBy(String date) {
    return 'الرد على طلب المعلومات بحلول $date (من الرسالة)';
  }

  @override
  String get cnEnterDatePlanGave => 'أدخل تاريخا';

  @override
  String get cnUseLetterDate => 'استخدم تاريخ الرسالة';

  @override
  String get cnLeaveUnknown => 'اتركه غير معروف الآن';

  @override
  String get cnDateUnknownChecked => 'غير معروف، تم تدوينه';

  @override
  String get cnTypeAsWritten => 'اكتبه تماما كما يظهر في الرسالة.';

  @override
  String get cnCheckThisValue => 'تبدو هذه القيمة غير معتادة. قارنها بالرسالة.';

  @override
  String get cnDone => 'تم';

  @override
  String get cnEdit => 'تعديل';

  @override
  String get cnAdd => 'إضافة';

  @override
  String get cnNoRecordsToLink =>
      'لا توجد سجلات من آخر 30 يوما لربطها. ما زال بإمكانك تحديد من لديه هذا العنصر.';

  @override
  String cnLinkTitle(String label) {
    return 'ربط سجل بـ: $label';
  }

  @override
  String get cnLinkNote =>
      'سجلاتك الخاصة تدعم الطلب. لكنها لا تحل محل ملاحظات العيادة أو نتائج الفحوص.';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '$taken تم تناولها / $notTaken لم تُتناول / $unknown غير معروفة، من أصل $scheduled جرعة مجدولة';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return 'عند الحاجة — مرات الاستخدام: $uses، عدد البخات: $puffs';
  }

  @override
  String get cnNoEntries => 'لا توجد إدخالات';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return 'أيام الأعراض: $days، أيام الاستيقاظ الليلي: $night (أيام مسجلة: $entries من $total)';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return 'بيانات PM2.5: $days من $total يوما؛ أيام فوق AQI 100: $high';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملاحظة منك',
      many: '$count ملاحظة منك',
      few: '$count ملاحظات منك',
      two: 'ملاحظتان منك',
      one: 'ملاحظة واحدة منك',
      zero: '$count ملاحظات منك',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => 'بيانات وهمية';

  @override
  String get cnLetterAsksFor => 'ما تطلبه الرسالة';

  @override
  String get cnNoItemsListed =>
      'لا تذكر الرسالة عناصر محددة. يمكنك إضافة عناصرك.';

  @override
  String get cnAddItemLabel => 'أضف عنصرا لتتبعه';

  @override
  String cnYourRecords(String from, String to) {
    return 'سجلاتك ($from – $to)';
  }

  @override
  String get cnLocalContextNote =>
      'اختياري. هذه عوامل خارجية، وليست قياسًا داخل المنزل ولا سبب الأعراض.';

  @override
  String get cnContinueToPacket => 'المتابعة إلى حزمة المستندات';

  @override
  String get cnAddedByYou => 'أضفته أنت';

  @override
  String get cnFromLetter => 'من الرسالة';

  @override
  String cnWhoHasIt(String who) {
    return 'لدى من: $who';
  }

  @override
  String cnLinkedTo(String record) {
    return 'مرتبط: $record';
  }

  @override
  String get cnSeeInLetter => 'عرض في الرسالة';

  @override
  String get cnLinkRecords => 'ربط سجلاتي';

  @override
  String get cnOtherStatus => 'حالة أخرى';

  @override
  String get cnInPacket => 'في حزمة المستندات';

  @override
  String get cnRemoveFromPacket => 'إزالة من حزمة المستندات';

  @override
  String get cnAddToPacket => 'إضافة إلى حزمة المستندات';

  @override
  String get cnErrNotSavedYet =>
      'آخر تغييراتك لم تُحفظ بعد. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get cnPacketChangedMeanwhile =>
      'تغيرت المعلومات أو السجلات أثناء إنشاء حزمة المستندات. أنشئها مرة أخرى.';

  @override
  String get cnPacketFailed => 'تعذر إنشاء حزمة المستندات. حاول مرة أخرى.';

  @override
  String get cnBeforeSharingTitle => 'قبل أن تشارك';

  @override
  String get cnBeforeSharingBody =>
      'يحتوي هذا الملف على اسمك وتفاصيلك الصحية. شاركه فقط مع فريق الرعاية أو خطة التأمين. المشاركة لا ترسل أي شيء نيابة عنك.';

  @override
  String get cnShare => 'مشاركة';

  @override
  String get cnMethodFax => 'فاكس';

  @override
  String get cnMethodMail => 'بريد عادي';

  @override
  String get cnMethodPortal => 'بوابة إلكترونية';

  @override
  String get cnMethodInPerson => 'شخصيا';

  @override
  String get cnMethodCareTeam => 'أرسله فريق الرعاية';

  @override
  String get cnMethodOther => 'أخرى';

  @override
  String get cnPacketNoDraftFinal =>
      'للقرار النهائي، تحتوي حزمة المستندات على ملخص الطبيب فقط. لا تُنشأ مسودة للمراجعة من المستوى الأول.';

  @override
  String get cnPacketNoDraftEob =>
      'لفاتورة أو شرح المزايا، تحتوي حزمة المستندات على ملخص الطبيب فقط.';

  @override
  String get cnPacketNoDraftReauth =>
      'لإشعار التجديد، تحتوي حزمة المستندات على ملخص الطبيب فقط، لمساعدة فريق الرعاية في التجديد.';

  @override
  String get cnPacketNoDraftOther =>
      'ما لم تكن الرسالة رفضا أو طلب معلومات، تحتوي حزمة المستندات على ملخص الطبيب فقط.';

  @override
  String get cnPacketContains => 'ستتضمن حزمة المستندات هذه';

  @override
  String get cnPartSummary => 'ملخص الطبيب (صفحة واحدة)';

  @override
  String get cnPartDraft => 'مسودة طلب مراجعة (ليكملها فريق الرعاية)';

  @override
  String get cnPartLetterText => 'ملحق: نص الرسالة';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أُضيف $count ملخص للسجلات',
      many: 'أُضيف $count ملخصا للسجلات',
      few: 'أُضيف $count ملخصات للسجلات',
      two: 'أُضيف ملخصان للسجلات',
      one: 'أُضيف ملخص واحد للسجلات',
      zero: 'لم تُضف ملخصات للسجلات',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => 'أضف نص الرسالة كملحق';

  @override
  String get cnPacketStale =>
      'تغيرت المعلومات أو السجلات منذ آخر حزمة مستندات. أنشئها مرة أخرى للتحديث.';

  @override
  String get cnGenerating => 'جارٍ الإنشاء…';

  @override
  String get cnGeneratePacket => 'إنشاء حزمة المستندات للمراجعة';

  @override
  String get cnSaveOrPrint => 'حفظ أو طباعة';

  @override
  String get cnISentIt => 'أرسلتها';

  @override
  String cnSharedOn(String date) {
    return 'تمت المشاركة في $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return 'قلت إنك أرسلتها في $date ($method)';
  }

  @override
  String get cnTabDoctorSummary => 'ملخص الطبيب';

  @override
  String get cnTabReviewDraft => 'مسودة طلب المراجعة';

  @override
  String get cnSentExplain =>
      'سجّل متى وكيف أُرسلت. لا يرسلها CoverNote ولا يتتبع القرار.';

  @override
  String get cnSave => 'حفظ';

  @override
  String get cnCtxPm25 => 'PM2.5 (AQI)';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => 'الرطوبة الخارجية';

  @override
  String cnObservedOn(String date) {
    return 'رُصد في $date';
  }

  @override
  String get cnCtxIntro =>
      'قراءات هواء من مصدر مسمى، وأشياء لاحظتها، كل منهما منفصل عن الآخر. أضفها إلى ملف فقط إذا ساعدت في شرح سجلاتك.';

  @override
  String get cnCtxReadings => 'قراءات الهواء';

  @override
  String get cnCtxReadingsNote =>
      'قراءات إقليمية لليوم الذي رُصدت فيه. وهي لا تقيس عادم حركة المرور في منزلك.';

  @override
  String get cnCtxAddReading => 'إضافة قراءة';

  @override
  String get cnCtxReports => 'ما لاحظته';

  @override
  String get cnCtxReportsNote => 'ملاحظات كتبتها أنت. ليست قياسات.';

  @override
  String get cnCtxAddReport => 'أضف ما لاحظته';

  @override
  String get cnReportExhaust => 'عادم قوي في الجوار';

  @override
  String get cnReportWater => 'تسرب مياه في المنزل';

  @override
  String get cnReportDamp => 'مكان داخلي رطب أو ذو رائحة عفنة';

  @override
  String cnOnDate(String date) {
    return 'التاريخ: $date';
  }

  @override
  String get cnNoteOptional => 'ملاحظة (اختياري)';

  @override
  String get cnCtxWhat => 'القراءة';

  @override
  String get cnCtxHumidityNote =>
      'الرطوبة الخارجية بيانات طقس. وهي لا تدل على الرطوبة أو العفن داخل منزلك.';

  @override
  String get cnCtxValue => 'القيمة';

  @override
  String get cnCtxValueInvalid => 'أدخل رقما صحيحا.';

  @override
  String get cnCtxSource => 'المصدر';

  @override
  String get cnCtxSourceHelp => 'من أين جاء الرقم، مثل AirNow أو جهاز رصد محلي';

  @override
  String get cnCtxSourceRequired => 'أضف المصدر.';

  @override
  String get cnCtxPlace => 'المكان (اختياري)';

  @override
  String get cnRecordsSignInBody =>
      'سجّل الدخول للاحتفاظ بسجلات الدواء والأعراض وعوامل البيئة.';

  @override
  String get cnRecordsYourRecords => 'سجلاتك';

  @override
  String get cnRecMedicationSub => 'الأدوية والجرعات التي تتناولها';

  @override
  String get cnRecDailyLog => 'السجل اليومي';

  @override
  String get cnRecDailyLogSub => 'الأعراض واستخدام البخاخ';

  @override
  String get cnRecLocalContextSub => 'قراءات الهواء وما لاحظته';

  @override
  String get cnHelp => 'المساعدة';

  @override
  String get cnUrgentHelp => 'مساعدة عاجلة';

  @override
  String get cnUrgentHelpSub =>
      'خطوات لحالة طوارئ في التنفس والاتصال بالرقم 911';

  @override
  String cnLast30Days(String from, String to) {
    return 'Last 30 days ($from – $to)';
  }

  @override
  String get cnNoSchedule => 'لم يُحدد جدول منتظم';

  @override
  String get cnRecordsUnknownNote =>
      'الأيام التي لا توجد فيها إدخالات تبقى غير معروفة. ولا تُحسب كأيام فائتة.';

  @override
  String get cnDeleteAccountTitle => 'هل تريد حذف حسابك؟';

  @override
  String get cnDeleteAccountBody =>
      'يحذف هذا حسابك وملفاتك والرسائل المرفوعة وحزم المستندات والسجلات نهائيا. لا يمكن التراجع عن ذلك.';

  @override
  String get cnTypeDelete => 'اكتب DELETE للتأكيد';

  @override
  String get cnDeleteAccount => 'حذف الحساب';

  @override
  String get cnAccountDeleted => 'تم حذف حسابك.';

  @override
  String get cnDeleteAccountFailed => 'تعذر حذف الحساب. حاول لاحقا.';

  @override
  String get cnAccountSignedOut => 'لم تسجل الدخول.';

  @override
  String get cnLanguage => 'اللغة';

  @override
  String get cnServiceStatus => 'خدمة قراءة الرسائل';

  @override
  String get cnServiceReady => 'متاحة';

  @override
  String get cnServiceUnavailableShort => 'غير متاحة الآن';

  @override
  String get cnChecking => 'جارٍ التحقق…';

  @override
  String get cnServiceUnknown => 'لم يتم التحقق';

  @override
  String get cnCheck => 'تحقق';

  @override
  String get cnAbout => 'حول التطبيق';

  @override
  String get cnAboutBody =>
      'يساعدك CoverNote على قراءة رسائل التأمين عن الأدوية وتجهيز أوراق لفريق الرعاية. لا يرسل أي شيء إلى خطة التأمين، ولا يقرر التغطية، وليس نصيحة طبية.';

  @override
  String get cnDangerZone => 'حذف الحساب';

  @override
  String get cnErrServiceUnavailable => 'قارئ الرسائل غير متاح الآن.';

  @override
  String get cnErrBusy => 'الخدمة مشغولة. انتظر دقيقة ثم حاول مرة أخرى.';

  @override
  String get cnErrSlow => 'استغرقت القراءة وقتا طويلا. حاول مرة أخرى.';

  @override
  String get cnErrUnreadable =>
      'تعذرت قراءة الصفحات. أعد تصويرها في إضاءة أفضل.';

  @override
  String get cnErrTooManyPages =>
      'صفحات كثيرة جدا. الحد الأقصى للرفع 10 صفحات.';

  @override
  String get cnErrTooLarge => 'الملفات كبيرة جدا. استخدم صفحات أقل أو أصغر.';

  @override
  String get cnErrStale => 'تغير هذا الملف على جهاز آخر. نعرض أحدث نسخة.';

  @override
  String get cnErrCaseGone => 'هذا الملف لم يعد موجودا.';

  @override
  String get cnErrAttempts =>
      'فشلت القراءة عدة مرات. استبدل الصفحات أو حاول لاحقا.';

  @override
  String get cnErrDemoUpload =>
      'العرض التجريبي لا يستطيع قراءة الملفات. سجل الدخول لمسح رسالتك ضوئيا.';

  @override
  String cnErrGeneric(String code) {
    return 'حدث خطأ ما ($code). حاول مرة أخرى.';
  }

  @override
  String get cnLanguageChoose => 'اختر لغتك';

  @override
  String get cnLanguageNote =>
      'ترجم برنامج بعض النص وقد يحتوي على أخطاء. يبقى اسم الدواء والجرعة كما هو مكتوب. يُترجم باقي الخطاب لك.';

  @override
  String get cnLanguageButtonTooltip => 'تغيير اللغة';

  @override
  String get cnPacketEnglishNote =>
      'حزمة المستندات مكتوبة بالإنجليزية حتى يقرأها فريق الرعاية.';

  @override
  String get cnReasonMissingInformation =>
      'تقول خطة التأمين إنها لم تستلم كل المعلومات التي احتاجتها.';

  @override
  String get cnReasonStepTherapy =>
      'تريد خطة التأمين أن تجرب أدوية أخرى أولا (Step therapy).';

  @override
  String get cnReasonMedicalNecessity =>
      'تقول خطة التأمين إنها لم تتمكن من التأكد من أن هذا الدواء ضروري طبيا (Medical necessity).';

  @override
  String get cnReasonFormulary =>
      'تقول خطة التأمين إن هذا الدواء ليس على قائمة الأدوية التي تغطيها (Formulary).';

  @override
  String get cnReasonQuantityLimit =>
      'تقول خطة التأمين إن الكمية المطلوبة أكثر مما تغطيه.';

  @override
  String get cnReasonEligibility =>
      'تقول خطة التأمين إن هذا غير مغطى حسب قواعد التغطية لديها.';

  @override
  String get cnReasonOther =>
      'تذكر الرسالة سببا آخر. افتح الاقتباس من الرسالة لقراءته.';

  @override
  String get cnReqHintMedHistory => 'أدويتك السابقة والحالية';

  @override
  String get cnReqHintVisitNotes => 'ملاحظات من زيارات طبيبك';

  @override
  String get cnReqHintTestResults => 'نتائج الفحوص أو المختبر';

  @override
  String get cnReqHintDoctorStatement => 'إفادة من طبيبك';

  @override
  String get cnTabSettings => 'الإعدادات';

  @override
  String get cnCasesList => 'قائمة الملفات';

  @override
  String get cnGoHome => 'الرئيسية';

  @override
  String get cnAnalyzingTitle => 'رسالة التأمين · جارٍ القراءة';

  @override
  String cnCaseNumber(String n) {
    return 'ملف #$n';
  }

  @override
  String cnAddedAt(String when) {
    return 'أُضيف $when';
  }

  @override
  String get cnAliasHint => 'اسم مختصر (اختياري)';

  @override
  String get cnShareDocuments => 'إرسال المستندات';

  @override
  String get cnRecordDelivery => 'تسجيل الإرسال';

  @override
  String get cnShareAsk => 'هل أرسلت هذه المستندات؟';

  @override
  String get cnDeliveryRecipient => 'أُرسلت إلى';

  @override
  String get cnRecipientClinic => 'العيادة أو الطبيب';

  @override
  String get cnRecipientInsurer => 'خطة التأمين';

  @override
  String get cnRecipientSelf => 'احتفظت بها لنفسي';

  @override
  String get cnRecipientOther => 'أخرى';

  @override
  String get cnDeliveryMethod => 'كيف';

  @override
  String get cnMethodEmail => 'البريد الإلكتروني';

  @override
  String get cnMethodMessage => 'رسالة نصية أو محادثة';

  @override
  String get cnMethodUnknown => 'لا أتذكر';

  @override
  String get cnDeliveryUserReport =>
      'هذا ما ذكرته. لا يستطيع التطبيق تأكيد أن الطرف الآخر استلمها.';

  @override
  String get cnShareCancelled => 'أُلغي الإرسال. لم يُسجَّل أي شيء كمرسل.';

  @override
  String get cnRecordsLoading => 'جارٍ تحميل السجلات…';

  @override
  String get cnRecordsEmpty => 'لا سجلات في هذه الفترة';

  @override
  String get cnRecordsError => 'تعذر تحميل السجلات';

  @override
  String get cnRecordsPermission => 'ليست لديك صلاحية الوصول إلى هذه السجلات';

  @override
  String get cnRecordsPending => 'محفوظ على هذا الهاتف · بانتظار المزامنة';

  @override
  String get cnRecordsFiltered => 'بعض السجلات مخفية بسبب عوامل التصفية';

  @override
  String cnRecordsOutside(int n) {
    return '$n سجلات خارج هذه الفترة';
  }

  @override
  String get cnWidenRange => 'عرض فترة أطول';

  @override
  String cnLinkedSummary(int days, int med, int sym) {
    return '$days أيام · $med استخدامات للدواء · $sym تسجيلات للأعراض';
  }

  @override
  String get cnOneDayPacket => 'تغطي هذه المستندات يوما واحدا.';

  @override
  String get cnMyMedications => 'أدويتي';

  @override
  String get cnScanLabel => 'مسح ملصق الدواء';

  @override
  String get cnMedManageHint =>
      'سجّل الأدوية التي تستخدمها. غيّرها إذا تغيّرت الوصفة. الاستخدام اليومي يُسجَّل في السجلات.';

  @override
  String get cnLabelNeedLabel =>
      'صوّر ملصق الصيدلية أو النص على العلبة. التطبيق لا يتعرف على الحبة من شكلها.';

  @override
  String get cnLabelUnclear => 'هذه القيمة غير واضحة. راجعها قبل الحفظ.';

  @override
  String get cnConsentLabel => 'السماح للذكاء الاصطناعي بقراءة ملصق دواء';

  @override
  String get cnManualMed => 'إدخال يدوي';

  @override
  String get cnAirWeather => 'عوامل البيئة القريبة منك';

  @override
  String get cnAirAutoNote =>
      'تُجلب جودة الهواء والهواء المرتبط بالمرور وحبوب اللقاح وتنبيهات الفيضان والرطوبة الخارجية من موقعك. الهاتف لا يقيس الهواء. الرطوبة الخارجية ليست عفنًا داخل المنزل.';

  @override
  String get cnHomeRecords => 'سجلات الدواء ذات الصلة';

  @override
  String get cnEnvTrap => 'الهواء المرتبط بالمرور';

  @override
  String get cnItemMemo => 'ملاحظة';

  @override
  String get cnSaveNote => 'حفظ الملاحظة';

  @override
  String get cnLocationNeed => 'اسمح بالموقع لعرض عوامل البيئة القريبة منك.';

  @override
  String get cnLocationOff => 'خدمات الموقع متوقفة. شغّلها ثم أعد المحاولة.';

  @override
  String get cnLocationBlocked => 'الموقع محظور. اسمح به في الإعدادات.';

  @override
  String get cnOpenSettings => 'فتح الإعدادات';

  @override
  String get cnAirNone => 'لا بيانات للهواء أو الطقس';

  @override
  String get cnAirRetry => 'إعادة محاولة الهواء والطقس';

  @override
  String get cnSetRegion => 'Set your area (ZIP or city)';

  @override
  String get cnConfiguredArea => 'Area you set';

  @override
  String get cnRecordPlace => 'مكان هذا السجل';

  @override
  String get cnClosestObservation => 'Closest observation to the record time';

  @override
  String get cnEnvUnavailable => 'لا يوجد قياس مطابق لذلك الوقت';

  @override
  String cnLogMedication(String name) {
    return 'تسجيل $name';
  }

  @override
  String get cnAsNeededUse => 'استخدام عند الحاجة';

  @override
  String get cnAsNeededInhaler => 'As-needed inhaler use';

  @override
  String get cnScheduledUse => 'استخدام في موعده';

  @override
  String get cnExtraUse => 'استخدام إضافي';

  @override
  String get cnUndoUse => 'تراجع';

  @override
  String get cnLoggedLocal => 'محفوظ على هذا الهاتف';

  @override
  String get cnLoggedPending => 'بانتظار المزامنة';

  @override
  String get cnLoggedSynced => 'تمت المزامنة';

  @override
  String cnDaysLogged(int n) {
    return 'سُجِّل في $n أيام هذا الأسبوع';
  }

  @override
  String get cnManageMedsLink => 'إدارة أدويتي';

  @override
  String get cnViewAirWeather => 'View environmental factors near you';

  @override
  String get cnConsentAi => 'السماح للذكاء الاصطناعي بقراءة المستندات';

  @override
  String get cnConsentAiBody =>
      'تُرسل صورة الرسالة إلى خدمة قراءة حتى يعرض CoverNote ما فيها. يمكنك إيقاف ذلك لاحقا في الإعدادات.';

  @override
  String get cnConsentAndAnalyze => 'موافقة وقراءة';

  @override
  String get cnConsentLater => 'ليس الآن';

  @override
  String get cnConsentViewLocal => 'عرض الأصل هنا';

  @override
  String get cnConsentDetails => 'المزيد عن استخدام البيانات';

  @override
  String get cnConsentLabelPurpose => 'قراءة ملصق دواء';

  @override
  String get cnConsentLetterPurpose => 'قراءة رسالة تأمين';

  @override
  String get cnConsentTranslatePurpose => 'ترجمة رسالة';

  @override
  String get cnToday => 'اليوم';

  @override
  String get cnLast7 => 'آخر 7 أيام';

  @override
  String get cnLast30 => 'آخر 30 يوما';

  @override
  String get cnCustomRange => 'اختيار التواريخ';

  @override
  String cnRangeSummary(String from, String to, int days, int count) {
    return '$from–$to · $days أيام · $count سجلات';
  }

  @override
  String get cnNoRecordThatDay => 'لا سجل في هذا اليوم';

  @override
  String get cnNotLogged => 'غير مسجَّل';

  @override
  String get cnNotTaken => 'معلَّم بأنه لم يُؤخذ';

  @override
  String get cnOriginalFile => 'الملف الأصلي';

  @override
  String get cnFullTranslation => 'الترجمة الكاملة';

  @override
  String get cnRecognizedText => 'النص المتعرَّف عليه';

  @override
  String get cnSameLanguage => 'نفس لغة الأصل';

  @override
  String get cnTranslationPartial => 'بعض الصفحات لم تُترجم بعد';

  @override
  String get cnTranslationFailed => 'تعذر ترجمة هذه الصفحة';

  @override
  String get cnOriginalMissing =>
      'تعذر العثور على الملف الأصلي. يمكنك رفعه مرة أخرى.';

  @override
  String get cnTranslateRetry => 'متابعة الترجمة';

  @override
  String get cnKeyDetails => 'التفاصيل المهمة';

  @override
  String get cnWhatAbout => 'عمّ تتحدث هذه الرسالة؟';

  @override
  String get cnWhatToDo => 'ماذا تفعل الآن';

  @override
  String get cnByWhen => 'حتى متى؟';

  @override
  String get cnPreparePacket => 'تجهيز المستندات';

  @override
  String get cnCorrectReading => 'تصحيح خطأ في القراءة';

  @override
  String get cnCorrectReadingNote =>
      'الرسالة الأصلية لا تتغير. تُصحَّح القراءة التلقائية فقط.';

  @override
  String get cnReviewImportant => 'راجع هذه القيم المهمة قبل إنشاء المستندات';

  @override
  String get cnPacketReadyTitle => 'مستنداتك جاهزة';

  @override
  String get cnNextSendClinic => 'أرسل المستندات إلى طبيبك واطلب منه مراجعتها';

  @override
  String get cnNextWaitReply => 'عندما يصلك رد، سجّل النتيجة';

  @override
  String get cnExistingSentNewReady =>
      'أُرسلت مستندات سابقة · يمكنك إعداد مجموعة جديدة';

  @override
  String get cnWhyRecords =>
      'سجلات الدواء والأعراض تساعد الطبيب على متابعة العلاج. يمكنك إعداد مستندات من الرسالة حتى إن لم تكن لديك سجلات بعد.';

  @override
  String get cnLetterAskedRecords => 'طلبت الرسالة سجلات علاج حديثة';

  @override
  String get cnOptionalReference => 'مرجع اختياري';

  @override
  String get cnAsthmaContext =>
      'سجلات علاج الربو — الاستخدام في موعده، والاستخدام عند الحاجة، وأعراض التنفس.';

  @override
  String get cnGeneralContext =>
      'سجلات العلاج — استخدام الدواء والأعراض أو الملاحظات.';

  @override
  String get cnTreatmentQuestion => 'عن أي علاج تتحدث هذه الرسالة؟';

  @override
  String get cnTreatmentAsthma => 'الربو';

  @override
  String get cnTreatmentOther => 'علاج آخر';

  @override
  String get cnTreatmentUnknown => 'لست متأكدا بعد';

  @override
  String get cnStatusWaitingClinic => 'أُرسل إلى العيادة · بانتظار المراجعة';

  @override
  String get cnStatusWaitingInsurer =>
      'سُجِّل أنه قُدِّم إلى الخطة · بانتظار الرد';

  @override
  String get cnFollowUpNeeded => 'يلزم متابعة';

  @override
  String get cnOutcomeRecorded => 'سُجِّلت النتيجة';

  @override
  String get cnActiveCases => 'قيد المتابعة';

  @override
  String get cnCompletedArchived => 'مكتمل ومؤرشف';

  @override
  String get cnCompleteCase => 'إكمال هذا الملف';

  @override
  String get cnArchiveCase => 'أرشفة';

  @override
  String get cnReopenCase => 'استئناف';

  @override
  String get cnOutcomeApproved => 'موافقة';

  @override
  String get cnOutcomeDenied => 'رفض';

  @override
  String get cnOutcomeStopped => 'لن أتابع';

  @override
  String get cnOutcomeOther => 'أخرى / غير مسجَّل';

  @override
  String get cnSentIsNotComplete => 'الإرسال ليس إكمالا للملف.';

  @override
  String get cnArchivedCase => 'مؤرشف';

  @override
  String get cnStepKeyDetails => 'التفاصيل المهمة';

  @override
  String get cnStepAddRecords => 'إضافة سجلاتي';

  @override
  String get cnStepReviewPacket => 'مراجعة المستندات';

  @override
  String get cnDataConsent => 'معالجة البيانات';

  @override
  String get cnZipOrCity => 'ZIP or city';

  @override
  String get cnSaveArea => 'Save area';

  @override
  String get cnWeekCalendar => 'هذا الأسبوع';

  @override
  String get cnMonthCalendar => 'هذا الشهر';

  @override
  String get cnUsedShort => 'استخدمته';

  @override
  String get cnCalendarLegend =>
      'النقطة تعني أنك سجّلت شيئا في ذلك اليوم. اليوم الفارغ ليس جرعة فائتة.';
}
