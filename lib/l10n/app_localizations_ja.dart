// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Howse Asthma';

  @override
  String get loginTitle => 'ログイン';

  @override
  String get loginEmailLabel => 'メール';

  @override
  String get loginPasswordLabel => 'パスワード';

  @override
  String get loginButton => 'ログイン';

  @override
  String get signUpButton => '新規登録';

  @override
  String get supabaseNotConfigured =>
      'Supabase がまだ設定されていません。\n.env ファイルに SUPABASE_URL と SUPABASE_ANON_KEY を追加してください。';

  @override
  String get homeGreeting => 'こんにちは';

  @override
  String get homeAirQualityTitle => '近くの大気質';

  @override
  String get homeWeatherTitle => '近くの天気';

  @override
  String get asthmaRiskLow => '喘息リスク：低';

  @override
  String get asthmaRiskModerate => '喘息リスク：中';

  @override
  String get asthmaRiskHigh => '喘息リスク：高 — 注意してください';

  @override
  String get medicationLogTitle => '服薬記録';

  @override
  String get medicationLogAddButton => '吸入器 / 薬の使用を記録';

  @override
  String get medicationNameLabel => '薬の名前';

  @override
  String get medicationDoseLabel => '用量';

  @override
  String get medicationTimeLabel => '服用時刻';

  @override
  String get medicationEffectivenessLabel => '効果はありましたか？';

  @override
  String get reportTitle => '保険レポート';

  @override
  String get reportGenerateButton => '医師 / 保険向けレポートを作成';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguageLabel => '言語';

  @override
  String get settingsLocationLabel => '位置情報';

  @override
  String get notificationAttackWarningTitle => '喘息発作リスクアラート';

  @override
  String get mockContinue => '続ける';

  @override
  String get mockSignUpTitle => 'アカウント作成';

  @override
  String get mockChooseRole => '役割を選択';

  @override
  String get mockRolePatient => '患者';

  @override
  String get mockRolePatientHint => '空気リスクと吸入器の使用を記録';

  @override
  String get mockRoleProvider => '医療者';

  @override
  String get mockRoleProviderHint => 'このデザインプレビューには含まれません';

  @override
  String get mockProviderNotInPreview => '医療者画面はこの患者デザインプレビューにありません。';

  @override
  String get mockBiometricTitle => 'ロック解除';

  @override
  String get mockBiometricHint => '生体認証で Howse Asthma をロック解除（デザインプレビュー）。';

  @override
  String get mockUnlock => 'ロック解除';

  @override
  String get mockUsePassword => '代わりにパスワードを使う';

  @override
  String get mockOnboardingTitle => '患者セットアップ';

  @override
  String get mockHomeLocation => '自宅';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => '緊急連絡先';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => '医療者の招待コード';

  @override
  String get mockFinishOnboarding => 'ホームへ';

  @override
  String get mockAllScreens => 'すべての画面';

  @override
  String get mockAllScreensHint => 'デザイン確認のため任意の Screen ID を開く';

  @override
  String get mockStateCalm => 'CALM';

  @override
  String get mockStateWarning => 'WARNING';

  @override
  String get mockHomeCalmMessage => '近くの空気は管理できそうです。いつでも吸入器を記録できます。';

  @override
  String get mockHomeWarnMessage => '近くのリスクが高まっています。屋外での滞在を控え、吸入器を手元に。';

  @override
  String get mockRiskScore => 'リスクスコア';

  @override
  String get mockDummyLocation => 'Newark, NJ 付近';

  @override
  String get mockEnvDetail => '環境の詳細';

  @override
  String get mockForecast => '予報';

  @override
  String get mockForecastHint => '今後数日の大気・花粉の見通し';

  @override
  String get mockAlertPreview => 'アラート画面';

  @override
  String get mockAlertPreviewHint => 'リスクアラート画面のプレビュー';

  @override
  String get mockShowWarningHome => 'WARNING ホームをプレビュー';

  @override
  String get mockBackToCalmHome => '戻る';

  @override
  String get mockPanicCta => 'パニックモード';

  @override
  String get mockTrapAxis => 'TRAP / 煤';

  @override
  String get mockFloodAxis => '鉄砲水';

  @override
  String get mockPollenAxis => '花粉';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · 花粉の見通し';

  @override
  String get mockActSurvey => 'ACT アンケート';

  @override
  String get mockActHint => '絵文字の質問 5 問（4 週間）';

  @override
  String get mockPdcCheck => '毎日の PDC 確認';

  @override
  String get mockPdcHint => 'ワンタップで服薬確認';

  @override
  String get mockInhalerEvent => '吸入器を記録済み';

  @override
  String get mockActIntro => '過去 4 週間に基づいて答えてください。デザインプレビュー — 回答は保存されません。';

  @override
  String get mockQuestion => '質問';

  @override
  String get mockSubmit => '送信';

  @override
  String get mockPdcPrompt => '今日はコントローラー薬を飲みましたか？';

  @override
  String get mockTakenYes => 'はい、飲みました';

  @override
  String get mockTakenNo => '今日は飲んでいない';

  @override
  String get mockEvidenceSummary => 'エビデンスの要約';

  @override
  String get mockEvidenceBody => 'PA/LMN 支援用のダミー要約です。デザインプレビューのみ。';

  @override
  String get mockInhalerEvents30d => '吸入器イベント（30 日）';

  @override
  String get mockActScore => '最新の ACT';

  @override
  String get mockPdcRate => 'PDC（30 日）';

  @override
  String get mockLocationsTitle => '保存した場所';

  @override
  String get mockLocationsHint => '自宅と職場のモニタリング';

  @override
  String get mockWorkLocation => '職場';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => '場所を追加';

  @override
  String get mockRewardTitle => 'リワード';

  @override
  String get mockDraftBanner => '下書き — ポイントとバウチャーはプレビューのみ';

  @override
  String get mockPointsBalance => 'ポイント残高';

  @override
  String get mockVoucherTitle => 'フードバンクバウチャー';

  @override
  String get mockVoucherHint => 'ポイント交換（待機リスト）';

  @override
  String get mockDonateTitle => '寄付';

  @override
  String get mockDonateHint => '第三者への寄付のみ';

  @override
  String get mockRewardHistory => '履歴';

  @override
  String get mockRewardHistoryHint => 'ポイントと寄付';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank（デモ）';

  @override
  String get mockVoucherCost => '50 ポイント · \$10 相当（下書き）';

  @override
  String get mockJoinWaitlist => '待機リストに参加';

  @override
  String get mockDonateTransparency =>
      '寄付は検証済みの第三者非営利プラットフォーム経由です。Howse Asthma はカード情報を保存しません。';

  @override
  String get mockDonateCta => '寄付を開く（外部）';

  @override
  String get mockExternalOnly => '外部の寄付プロバイダーはデザインプレビューに接続されていません。';

  @override
  String get mockSignOutPreview => 'ログアウト（プレビュー）';

  @override
  String get mockOpenAuthFlow => '認証フローを開く';

  @override
  String get mockAlertBody => '位置付近でリスクが上がりました。環境の詳細を確認してください。';

  @override
  String get mockDismiss => '閉じる';

  @override
  String get mockPanicTitle => '今すぐ助けが必要ですか？';

  @override
  String get mockPanicStep1Body => 'ステップ 1 — 吸入器を手元に。続けて緊急連絡先へ。';

  @override
  String get mockPanicStep2Title => '助けを呼ぶ';

  @override
  String get mockPanicStep2Body =>
      'デザインプレビュー：ボタンは実際の通話を発信しません。端末ビルドではステップ 2 が tel: リンクを使います。';

  @override
  String get mockCall911 => '911 に電話';

  @override
  String get mockCallGuardian => '緊急連絡先に電話';

  @override
  String get mockFeelingBetter => '少し楽になりました';

  @override
  String get mockTabHome => 'ホーム';

  @override
  String get mockTabLog => '記録';

  @override
  String get mockTabReport => 'レポート';

  @override
  String get mockTabReward => 'リワード';

  @override
  String get mockTabSettings => '設定';

  @override
  String get navHome => 'ホーム';

  @override
  String get signUpTitle => 'アカウント作成';

  @override
  String get authChooseRole => '役割を選択';

  @override
  String get authRolePatient => '患者';

  @override
  String get authRolePatientHint => '大気質リスクと吸入器の使用を追跡';

  @override
  String get authRoleProvider => '医療者';

  @override
  String get authRoleProviderHint => '患者を連携し臨床エビデンスを確認';

  @override
  String get authFullNameLabel => '氏名';

  @override
  String get authNpiLabel => 'NPI 番号';

  @override
  String get authNpiHelper => '10 桁の国家医療提供者識別番号';

  @override
  String get authOrContinueWith => 'または次で続行';

  @override
  String get authContinueGoogle => 'Google で続行';

  @override
  String get authContinueApple => 'Apple で続行';

  @override
  String get authCheckEmailTitle => 'メールを確認';

  @override
  String authCheckEmailBody(String email) {
    return '$email に確認リンクを送りました。開いてからサインインしてください。';
  }

  @override
  String get authBackToSignIn => 'サインインに戻る';

  @override
  String get authCompleteProfileTitle => 'プロフィールを完成';

  @override
  String get authCompleteProfileBody => '正しいホーム画面を開くため、あなたについて教えてください。';

  @override
  String get authSaveProfile => 'プロフィールを保存';

  @override
  String get authSignOut => 'サインアウト';

  @override
  String get authRetry => '再試行';

  @override
  String get authWorking => '処理中…';

  @override
  String get authValidationInvalidEmail => '有効なメールを入力してください';

  @override
  String get authValidationPasswordMin => 'パスワードは 8 文字以上である必要があります';

  @override
  String get authValidationNameRequired => '名前は必須です';

  @override
  String get authValidationInvalidNpi => '有効な 10 桁の NPI を入力してください';

  @override
  String get authErrorGeneric => '問題が発生しました。もう一度お試しください。';

  @override
  String get authErrorInvalidCredentials => 'メールまたはパスワードが無効です';

  @override
  String get authErrorEmailTaken => 'このメールのアカウントは既に存在します';

  @override
  String get authErrorEmailNotConfirmed => 'サインイン前にメールを確認してください';

  @override
  String get authErrorWeakPassword => 'パスワードが弱すぎます';

  @override
  String get authErrorRateLimited => '試行回数が多すぎます。後でもう一度お試しください。';

  @override
  String get authBiometricTitle => 'Howse Asthma をロック解除';

  @override
  String get authBiometricHint => '生体認証で続行';

  @override
  String get authBiometricReason => 'Howse Asthma をロック解除';

  @override
  String get authBiometricUnlock => 'ロック解除';

  @override
  String get authBiometricFailed => '生体認証によるロック解除に失敗しました。再試行してください。';

  @override
  String get authBiometricToggle => '生体認証ロック解除';

  @override
  String get authBiometricToggleHint => 'アプリ起動時に生体認証を要求';

  @override
  String get authBiometricUnavailable => 'この端末では生体認証を利用できません';

  @override
  String get authOnboardingTitle => '患者セットアップ';

  @override
  String get authOnboardingBody =>
      '臨床医から共有された 8 文字の招待コードがあれば、今入力してください。後で設定からもできます。';

  @override
  String get authOnboardingSkip => '今はスキップ';

  @override
  String get authInviteCodeLabel => '医療者の招待コード';

  @override
  String get authInviteCodeHelper => '英数字 8 文字、24 時間で期限切れ';

  @override
  String get authInviteRedeem => '利用する';

  @override
  String get authInviteRedeemAndContinue => '利用して続行';

  @override
  String get authInviteInvalidFormat => '招待コードは英数字 8 文字である必要があります';

  @override
  String get authInviteRedeemedPending => '招待を利用しました。医療者の確認待ちです。';

  @override
  String get authInviteRedeemFailed => '招待コードを利用できませんでした';

  @override
  String get authInviteIssueFailed => '招待コードを発行できませんでした';

  @override
  String get authConfirmLink => '確認';

  @override
  String get authRejectLink => '拒否';

  @override
  String get authLinkStatusPending => '確認待ち';

  @override
  String get settingsSystemDefault => 'システム既定';

  @override
  String get settingsLocationTodo => '位置情報の許可は今後のアップデートで求められます';

  @override
  String get providerHomeTab => 'ホーム';

  @override
  String get providerLinkTab => '連携';

  @override
  String get providerHomeTitle => '医療者ホーム';

  @override
  String providerHomeWelcome(String email) {
    return '$email としてサインイン中';
  }

  @override
  String get providerHomePlaceholder =>
      '患者の臨床ダッシュボードは今後のリリースで提供されます。まず患者を連携してください。';

  @override
  String get providerLinkPatientsCta => '患者を連携';

  @override
  String get providerLinkTitle => '患者を連携';

  @override
  String get providerLinkIntro => '8 文字のコードを発行します（24 時間有効）。患者が入力し、双方が確認します。';

  @override
  String get providerIssueInviteCta => '招待コードを発行';

  @override
  String get providerInviteTtlHint => '24 時間有効';

  @override
  String get providerInviteCopied => '招待コードをコピーしました';

  @override
  String get providerPendingLinks => '保留中の連携';

  @override
  String get providerNoPendingLinks => '保留中の連携はありません';

  @override
  String providerPendingPatient(String idPrefix) {
    return '患者 $idPrefix…';
  }

  @override
  String get providerRecentInvites => '最近の招待コード';

  @override
  String get providerNoInvites => 'まだ招待コードはありません';

  @override
  String get providerInviteConsumed => '使用済み';

  @override
  String get providerInviteActive => '有効';

  @override
  String get splashTagline => 'トリガーから守るスマートなシールド';

  @override
  String get splashGetStarted => 'はじめる';

  @override
  String get splashAlreadyHaveAccount => 'すでにアカウントがありますか？';

  @override
  String get splashSignIn => 'サインイン';

  @override
  String get authForgotPassword => 'パスワードをお忘れですか？';

  @override
  String get authNoAccount => 'アカウントがありませんか？';

  @override
  String get authUseBiometricHint => 'Face ID または指紋でロック解除';

  @override
  String get authTouchSensorHint => 'センサーに触れるかカメラを見てください';

  @override
  String get navLog => '記録';

  @override
  String get navReport => 'レポート';

  @override
  String get navRewards => 'リワード';

  @override
  String get mockChooseLanguage => '言語を選択';

  @override
  String get mockYourLocation => 'あなたの位置';

  @override
  String get mockUseCurrentLocation => '現在地を使う';

  @override
  String get mockLocationTrapOnly => '位置情報は TRAP 大気質データのみに使用されます';

  @override
  String get mockLabelYourPlace => '場所にラベルを付ける';

  @override
  String get mockSchool => '学校';

  @override
  String get mockWork => '職場';

  @override
  String get mockOther => 'その他';

  @override
  String get mockEmergencyOnePerson => '緊急時に電話する一人';

  @override
  String get mockContactName => '連絡先の名前';

  @override
  String get mockPhoneNumber => '電話番号';

  @override
  String get mockProviderPairing => '医療者とのペアリング';

  @override
  String get mockPairingOptional => '任意 — 後で設定から追加できます';

  @override
  String get mockNext => '次へ';

  @override
  String get mockProfessionalProfile => '専門プロフィール';

  @override
  String get mockStep2Of4 => 'ステップ 2 / 4';

  @override
  String get mockTellPractice => '診療について教えてください';

  @override
  String get mockSpecialtyLabel => '専門分野';

  @override
  String get mockClinicLabel => '診療所 / クリニック名';

  @override
  String get mockNpiFormatOnly => '形式チェックのみ。NPI 検証は送信後に行われます。';

  @override
  String get mockCredentialsSecure => '資格情報は暗号化して安全に保存されます。同意なく医療者データを共有しません。';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => '吸入器の使用を記録しました（stub）';

  @override
  String get oneTapLoggedOk => '吸入器の使用を記録しました';

  @override
  String get oneTapLoggedFailed => '吸入器の使用を記録できませんでした。再試行してください。';

  @override
  String get homeDailySummary => '本日のまとめです';

  @override
  String get homeWarningBanner => '近くのリスクが高まっています。屋外での滞在を控え、吸入器を手元に。';

  @override
  String get homeEnvFactors => '環境要因';

  @override
  String get homeViewDetails => '詳細を見る';

  @override
  String get homeFloodActive => '有効な警報';

  @override
  String get homeFloodNone => 'なし';

  @override
  String get homeLastInhalerNone => 'まだ吸入器の使用記録がありません';

  @override
  String get homeLastInhalerToday => '最後の吸入器使用：今日';

  @override
  String homeLastInhalerDays(int days) {
    return '最後の吸入器使用：$days 日前';
  }

  @override
  String get locationServiceDisabled => '近くの喘息リスクを表示するには位置情報サービスをオンにしてください。';

  @override
  String get locationPermissionDenied => '近くの大気質には位置情報の許可が必要です。';

  @override
  String get locationPermissionDeniedForever =>
      '位置情報の許可がブロックされています。設定で許可してください。';

  @override
  String get locationUnavailable => '位置を取得できませんでした。引っ張って更新するか再試行してください。';

  @override
  String get locationOutOfServiceArea => 'Howse Asthma は現在、米国の位置をサポートしています。';

  @override
  String get locationOpenSettings => '設定を開く';

  @override
  String get locationStatusGranted => '位置情報アクセスはオンです';

  @override
  String get njOnlyDataNotice =>
      'NJ 専用データ：貨物 AADT の重み付けはニュージャージーのみ適用。TRAP は全国の大気質センサーを引き続き使用します。';

  @override
  String get homeDegradedNotice => '一部の大気質ソースが利用できません。リスクが不完全な場合があるため注意してください。';

  @override
  String logWeekSummary(int count) {
    return '過去 7 日間の吸入器イベント $count 件';
  }

  @override
  String get logFilterAll => 'すべて';

  @override
  String get logFilterRescue => '救援';

  @override
  String get logFilterPanic => 'パニック';

  @override
  String get logEmpty => 'まだ吸入器イベントがありません。ホームで 1-Tap を使ってください。';

  @override
  String get logEventRescue => '吸入器の使用';

  @override
  String get logEventPanic => 'パニック時の吸入器使用';

  @override
  String get actTitle => '喘息チェック';

  @override
  String get actPast4Weeks => '過去 4 週間で';

  @override
  String get actQ1 => '喘息のせいで仕事・学校・家で普段どおりできなかった時間はどのくらいでしたか？';

  @override
  String get actQ2 => '息切れはどのくらいの頻度でありましたか？';

  @override
  String get actQ3 => '喘息症状で夜中に目が覚めたり、いつもより早く起きたりしたことはどのくらいありましたか？';

  @override
  String get actQ4 => '救援用吸入器やネブライザーをどのくらいの頻度で使いましたか？';

  @override
  String get actQ5 => '喘息のコントロールをどう評価しますか？';

  @override
  String get actOpt1 => 'いつも';

  @override
  String get actOpt2 => 'ほとんど';

  @override
  String get actOpt3 => 'ときどき';

  @override
  String get actOpt4 => 'まれに';

  @override
  String get actOpt5 => 'まったくない';

  @override
  String get actQ5Opt1 => 'まったくコントロールできていない';

  @override
  String get actQ5Opt2 => 'コントロール不良';

  @override
  String get actQ5Opt3 => 'ある程度コントロールできている';

  @override
  String get actQ5Opt4 => 'よくコントロールできている';

  @override
  String get actQ5Opt5 => '完全にコントロールできている';

  @override
  String actSaved(int score) {
    return 'ACT を保存しました。スコア：$score';
  }

  @override
  String get pdcTitle => '毎日の服薬確認';

  @override
  String get pdcSaved => '毎日の確認を保存しました';

  @override
  String get pdcAlreadyYes => '今日はすでに服用済みと記録しています。更新できます。';

  @override
  String get pdcAlreadyNo => '今日はすでに未服用と記録しています。更新できます。';

  @override
  String pdcStreakHint(int taken, int total, String rate) {
    return '過去 30 日：$total 日中 $taken 日服用（$rate）';
  }

  @override
  String get panicEmergencyBadge => '緊急';

  @override
  String get panicBreatheTitle => '呼吸して吸入器を使う';

  @override
  String get panicTakeInhalerNow => '今すぐ吸入器を使う';

  @override
  String get panicNeedHelp => 'もっと助けが必要です';

  @override
  String get panicNoAutoDial => 'ボタンは電話ダイヤラーを開きます。通話は自動では発信されません。';

  @override
  String panicCallNamed(String name) {
    return '$name に電話';
  }

  @override
  String get panicDialFailed => 'この端末で電話ダイヤラーを開けませんでした。';

  @override
  String get alertTitle => 'リスクアラート';

  @override
  String get alertFcmPendingNote =>
      'この端末でプッシュが有効なら、アプリがバックグラウンドでも OS 通知を受け取ります。';

  @override
  String get reportEvidenceBody => '臨床または保険レビュー向けの吸入器使用、ACT、PDC の要約。';

  @override
  String get reportShareTodo => '共有 / エクスポートは医療者の PA/LMN フローと一緒に提供されます。';

  @override
  String get settingsAlertsTitle => 'アラート設定';

  @override
  String get settingsAlertRisk => 'リスクアラート';

  @override
  String get settingsAlertRiskHint => '複合リスクスコアが 3 以上になったとき';

  @override
  String get settingsAlertHome => '保存した場所のアラート';

  @override
  String get settingsAlertHomeHint => '保存した場所（自宅・学校・職場）でリスクが上がったとき';

  @override
  String get settingsAlertLocationEntry => 'エリア入場アラート';

  @override
  String get settingsAlertLocationEntryHint => 'アプリ使用中によりリスクの高いエリアに入ったとき';

  @override
  String get settingsSecurityTitle => 'セキュリティ';

  @override
  String get emergencyContactRequired => '連絡先の名前と電話番号を入力してください';

  @override
  String get emergencyContactInvalidPhone =>
      '国番号付きの有効な電話番号（E.164）を入力してください。例：+15551234567';

  @override
  String get emergencyContactSaved => '緊急連絡先を保存しました';

  @override
  String get emergencyContactSave => '連絡先を保存';

  @override
  String get emergencyContactPhoneHint => '国番号（E.164）を含めてください。例：+15551234567';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '削除';

  @override
  String get envTitle => '環境';

  @override
  String get envThreeAxis => '3 つのリスク軸';

  @override
  String get envTrapDetail => '交通関連大気汚染の代理指標（センサー + 任意の NJ 貨物重み）';

  @override
  String get envTrapTip => 'TRAP が HIGH または CRITICAL のときは屋外での激しい活動を控えてください。';

  @override
  String get envFloodDetail => '近くの NWS 鉄砲水 / 河川警報';

  @override
  String get envFloodTipClear => 'この地域に有効な鉄砲水警報はありません。';

  @override
  String get envPollenDetail => 'Google 花粉予報';

  @override
  String get envPollenTip => 'UPI が高いときは窓を閉め、屋外の後は洗い流してください。';

  @override
  String envUsgsRate(String rate) {
    return 'USGS 河川変化：$rate ft/hr';
  }

  @override
  String envUpdatedAt(String when) {
    return '更新：$when';
  }

  @override
  String get envSourcesLabel => 'データソース';

  @override
  String get envOverallCalm => '状況は管理できそうです。吸入器を近くに置いてください。';

  @override
  String get forecastIntro => '大気質と花粉予報に基づく今後の見通しです。';

  @override
  String get forecastEmpty => '予報シリーズはまだ利用できません。引っ張って更新してください。';

  @override
  String get forecastPollenNote =>
      '花粉は Google Pollen API を使用します（Open-Meteo ではありません）。MVP ではヒートマップは使いません。';

  @override
  String forecastDayPollen(int upi, String type) {
    return '花粉 UPI $upi · $type';
  }

  @override
  String forecastDayAqi(int aqi) {
    return '最大 US AQI $aqi';
  }

  @override
  String get forecastMorning => '朝';

  @override
  String get forecastAfternoon => '昼';

  @override
  String get forecastEvening => '夜';

  @override
  String get locationsTitle => 'マイロケーション';

  @override
  String get locationsIntro =>
      'アプリ使用中、保存した場所のリスク変化を確認します。バックグラウンド OS プッシュには Firebase が必要です（次）。';

  @override
  String get locationsEmpty => '保存した場所はまだありません。現在地を追加してください。';

  @override
  String get locationsAddTitle => 'この場所を保存';

  @override
  String get locationsNameLabel => 'ラベル';

  @override
  String get locationsAddCurrent => '現在地を追加';

  @override
  String get locationsSaveFailed => '保存した場所を更新できませんでした。再試行してください。';

  @override
  String get locationsCapReached => '保存できる場所は最大 10 件です。追加するには 1 件削除してください。';

  @override
  String get locationsDeleteTitle => '場所を削除しますか？';

  @override
  String locationsDeleteBody(String name) {
    return 'モニタリングから「$name」を削除しますか？';
  }

  @override
  String locationsCoords(String lat, String lon) {
    return '$lat, $lon';
  }

  @override
  String get locationsPrimaryBadge => 'メイン';

  @override
  String get stateOnlyNjApplied => 'NJ 専用：貨物 AADT 重みを適用';

  @override
  String get stateOnlyNjNotApplied => 'NJ 専用：貨物 AADT 重み未適用';

  @override
  String get stateOnlyNjAppliedHint =>
      '近くの NJDOT 交通量が TRAP の重みを上げました。大気質センサーは全国で引き続き適用されます。';

  @override
  String get stateOnlyNjOutsideHint =>
      'ニュージャージー外です。貨物 AADT の重み付けは NJ 専用で、TRAP は空気センサーを引き続き使います。';

  @override
  String get stateOnlyNjNoCountHint =>
      '近くに NJDOT 貨物カウントがありません。TRAP は NJ 貨物重みなしで大気質センサーを使います。';

  @override
  String get settingsDeveloperSection => '開発者';

  @override
  String get settingsApiConsole => 'API コンソール';

  @override
  String get debugApiConsoleBanner => 'DEBUG — 公開共有用のスクリーンショットは避けてください';

  @override
  String get appTagline => 'トリガーから守るスマートなシールド';

  @override
  String get welcomeBenefit1 => '大気質・花粉リスクの先回りアラート';

  @override
  String get welcomeBenefit2 => '3秒でできる毎日の呼吸チェック';

  @override
  String get welcomeBenefit3 => '医師と共有できる信頼できるデータレポート';

  @override
  String get welcomeContinueEmail => 'またはメールで続ける';

  @override
  String get welcomeTermsAgree => '利用規約とプライバシーポリシーに同意します';

  @override
  String get welcomeTermsPending => '法務リンクは公開後に利用できます。';

  @override
  String get welcomeClinicianLink => '医療従事者です';

  @override
  String get checkInWelcomeHome => 'おかえりなさい！';

  @override
  String get checkInQuestion => '今の呼吸の状態は？';

  @override
  String get checkInBreathUsual => 'いつもどおり';

  @override
  String get checkInBreathTight => '少し苦しい';

  @override
  String get checkInBreathSymptoms => '症状がある';

  @override
  String get checkInAeroPoints => '初回チェックイン完了！+5 AeroPoints';

  @override
  String get shieldLocationTitle => '先制シールドを有効にする';

  @override
  String get shieldLocationBody => '周囲の先制シールドを有効にするため位置情報が必要です。';

  @override
  String get shieldLocationAllow => '位置情報を許可';

  @override
  String get shieldLocationNotNow => '今はしない';

  @override
  String get settingsPushMaster => 'プッシュ通知';

  @override
  String get settingsPushMasterHint => 'この端末の Howse Asthma 通知のマスタースイッチ';

  @override
  String get pushConsentTitle => '喘息のきっかけを先に知らせます';

  @override
  String get pushConsentBody => '近くの空気や洪水リスクが上がったとき、簡単な通知を送れます。設定でいつでも変更できます。';

  @override
  String get pushConsentAllow => '通知を許可';

  @override
  String get pushConsentNotNow => '今はしない';

  @override
  String homeNearPlace(String place) {
    return '$place の近く';
  }

  @override
  String get homeStaleLocationNotice => '位置を待つ間、前回の読み取りを表示しています。';

  @override
  String get homeStaleRefreshNotice => '前回の読み取りを表示中。接続できたら引き下げて更新してください。';

  @override
  String get homeStaleCacheNotice => 'この読み取りは少し古い可能性があります。注意してご覧ください。';

  @override
  String get homeNowDoThisHeading => '発作のリスクを下げるために今できること';

  @override
  String get homeDraftBadge => '草案';

  @override
  String get homeNowDoThisFloodTitle => 'できれば屋内にいてください';

  @override
  String get homeNowDoThisFloodBody =>
      '洪水警報は湿気と関係することがあります。吸入器を近くに置き、浸水地域を避けてください。';

  @override
  String get homeNowDoThisTrapTitle => '屋外活動を控えてください';

  @override
  String get homeNowDoThisTrapBody => '近くの交通関連の大気汚染が高そうです。必要なときだけ短く外出してください。';

  @override
  String get homeNowDoThisPollenTitle => '今は窓を閉めてください';

  @override
  String get homeNowDoThisPollenBody => '花粉が高いです。外出後は顔を洗い、服を着替えてください。';

  @override
  String get homeNowDoThisRiskTitle => '屋外ではゆっくり';

  @override
  String get homeNowDoThisRiskBody => '全体リスクが高めです。吸入器を持ち、息が苦しいときは休んでください。';

  @override
  String get homeNowDoThisCalmTitle => '換気しやすい時間帯';

  @override
  String get homeNowDoThisCalmBody => '外の空気はまずまずです。短く換気してもよいですが、吸入器は近くに。';

  @override
  String get homeAdherenceSection => '今週の吸入器';

  @override
  String get adherenceWeekHint => '色付きの日は 1-Tap 記録がある日です。';

  @override
  String get homeMoldAxis => 'カビリスク';

  @override
  String get homeMoldElevatedDraft => '湿気シグナル高め';

  @override
  String get homeMoldPendingDraft => '湿度データ待ち';

  @override
  String get homeFloodAsMoldFactor => '洪水・湿気要因';

  @override
  String get homeForecastLink => '短期見通し';

  @override
  String homeForecastHint(String date, String score) {
    return '翌日 $date · スコア $score';
  }

  @override
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  ) {
    return '最寄りセンサー $km km ($mi mi) · 検索 ~$radiusKm km ($radiusMi mi)';
  }

  @override
  String homeSensorNearestOnly(String km, String mi) {
    return '最寄りセンサー $km km ($mi mi)';
  }

  @override
  String homeSensorRadiusOnly(String km, String mi) {
    return 'センサー検索 ~$km km ($mi mi)';
  }

  @override
  String get weekdayMonShort => '月';

  @override
  String get weekdayTueShort => '火';

  @override
  String get weekdayWedShort => '水';

  @override
  String get weekdayThuShort => '木';

  @override
  String get weekdayFriShort => '金';

  @override
  String get weekdaySatShort => '土';

  @override
  String get weekdaySunShort => '日';

  @override
  String get logAdherenceCalendarTitle => '服薬カレンダー';

  @override
  String get homeNowDoThisMoldTitle => '室内の湿気を減らす';

  @override
  String get homeNowDoThisMoldBody =>
      '屋外の湿気が高そうです。可能なら扇風機や除湿機を使い、湿った地下室は避けてください。';

  @override
  String get homeMoldDetail => '付近の湿気条件（屋外の代理指標 — 胞子数ではありません）';

  @override
  String get homeMoldTip => 'カビリスクが高いときは部屋を乾燥気味に。洪水警報は湿気リスクを上げます。';

  @override
  String homeMoldRh(String pct) {
    return '湿度 $pct%';
  }

  @override
  String homeMoldTempF(String temp) {
    return '$temp°F';
  }

  @override
  String homeMoldDewF(String temp) {
    return '露点 $temp°F';
  }

  @override
  String homeMoldWetHours(int hours) {
    return '湿潤 $hours時間（24時間）';
  }

  @override
  String get homeMoldProxyDisclaimer => '屋外推定のみ';

  @override
  String get homeVentilationSnack => '外気が比較的穏やかです — 短い換気が役立つ場合があります。';

  @override
  String get settingsAlertPositive => '換気のヒント';

  @override
  String get settingsAlertPositiveHint => '外気が一時的に良いときに短い換気を案内（草案ルール）';

  @override
  String get settingsBgTitle => 'バックグラウンド更新';

  @override
  String get settingsBgBody => 'アプリ使用中に付近の空気を更新します。この版では常時位置は求めません。';

  @override
  String get settingsBgRefresh => 'アプリ使用中に更新';

  @override
  String get settingsBgRefreshHint => '移動時やアプリを開いている間にリスクを更新';

  @override
  String get s5AboutApp => 'Howse Asthma について';

  @override
  String get s5AboutAppBody =>
      'Howse Asthma は、症状と吸入器の使用を記録し、受診時に見せるまとめを作るのを手伝います。診断や治療の指示はしません。';

  @override
  String get s5ActNotice =>
      '回答は医師に共有できるよう保存されます。この質問票は公式の採点基準で確認されていないため、アプリは点数を表示しません。';

  @override
  String get s5ActSaved => '回答を保存しました。';

  @override
  String get s5ActSubtitle => '過去4週間についての5つの質問';

  @override
  String get s5ActTitle => 'ぜんそくコントロールの質問票';

  @override
  String get s5AddDetails => '詳細を追加';

  @override
  String get s5AddRecord => '記録を追加';

  @override
  String get s5AlertArrive => '新しい場所に着いたとき';

  @override
  String get s5AlertArriveHint => '着いた場所の周辺の状態が悪いとき。アプリを開いている間だけ動きます。';

  @override
  String get s5AlertFreshAirHint =>
      '屋外の空気の質・花粉・洪水の情報がどれも穏やかなとき。一般的な情報であり、医療上の助言ではありません。';

  @override
  String get s5AlertSavedPlaces => '保存した場所';

  @override
  String get s5AlertSavedPlacesHint => '保存した場所の周辺の状態が悪くなったとき。';

  @override
  String get s5AlertWorse => '環境が悪くなったとき';

  @override
  String get s5AlertWorseHint => '近くの空気の質・花粉・洪水の情報が悪くなったとき。同じ通知は1時間以内に繰り返しません。';

  @override
  String get s5AqiGood => '良い';

  @override
  String get s5AqiModerate => '普通';

  @override
  String get s5AqiUsg => '敏感な人には良くない';

  @override
  String get s5AqiUnhealthy => '良くない';

  @override
  String get s5AqiVeryUnhealthy => '非常に良くない';

  @override
  String get s5AqiHazardous => '危険';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category（AQI $aqi）';
  }

  @override
  String get s5Back => '戻る';

  @override
  String get s5BarrierCost => '薬の費用';

  @override
  String get s5BarrierHardToGet => '薬を手に入れるのが難しい';

  @override
  String get s5BarrierHardToUnderstand => '説明がわかりにくい';

  @override
  String get s5BarrierHowToUse => '薬の使い方';

  @override
  String get s5BarrierNone => '困っていることはない';

  @override
  String get s5BarrierOtherHint => '自分の言葉で書く（任意）';

  @override
  String get s5Cancel => 'キャンセル';

  @override
  String get s5Change => '変更';

  @override
  String get s5ChoosePlace => '地域を選ぶ';

  @override
  String get s5Close => '閉じる';

  @override
  String get s5DataSourcesTitle => 'データの出典';

  @override
  String get s5DataSourcesBody =>
      '空気の質：米国 EPA AirNow、Open-Meteo、近くの PurpleAir センサー。\n花粉：Google Pollen API（Universal Pollen Index）。\n天気・湿度：Open-Meteo。\n洪水警報：米国国立気象局（NWS）。河川の水位：米国地質調査所（USGS）。\n交通量（ニュージャージー州のみ）：ニュージャージー州交通局（NJDOT）。\n値が遅れたり欠けたりすることがあります。屋外の状態を示すもので、健康状態ではありません。';

  @override
  String get s5Delete => '削除';

  @override
  String get s5DeleteConfirm => 'この記録を削除しますか？';

  @override
  String get s5DeleteFailed => '削除できませんでした。もう一度お試しください。';

  @override
  String get s5Edit => '編集';

  @override
  String get s5EnglishVersion => '英語（医師向け）';

  @override
  String get s5EntryRemoved => '記録を取り消しました。';

  @override
  String get s5EnvAirDetail =>
      '公共の測定所と近くのセンサーによる、米国 EPA の空気質指数です。地域の屋外の空気を示し、交通の排気だけを測ったものではありません。';

  @override
  String get s5EnvAirQuality => '空気の質';

  @override
  String get s5EnvAlertsHeading => '環境の通知';

  @override
  String get s5EnvCardTitle => '今日の周辺環境';

  @override
  String get s5EnvFlood => '洪水警報';

  @override
  String get s5EnvFloodDetail => '米国国立気象局（NWS）の公開警報です。';

  @override
  String get s5EnvForecast => '環境の予報';

  @override
  String get s5EnvHumidity => '湿度';

  @override
  String get s5EnvHumidityDetail => '屋外の気象データです。室内の湿度やカビの測定値ではありません。';

  @override
  String get s5EnvLoadFailed => '環境情報を読み込めませんでした。';

  @override
  String get s5EnvNeedPlace => '地域を選ぶと、周辺の環境を見られます。';

  @override
  String get s5EnvNotAvailable => '確認できません';

  @override
  String get s5EnvOlderNotice => '最後に確認した情報です。';

  @override
  String get s5EnvPollen => '花粉指数';

  @override
  String get s5EnvPollenDetail =>
      'Google の Universal Pollen Index で、0（なし）から 5（非常に高い）までです。低い数字がすべての人に安全という意味ではありません。';

  @override
  String get s5EnvSeeDetails => '環境の詳細を見る';

  @override
  String get s5EnvUnavailable => 'いま環境情報を確認できません。';

  @override
  String get s5FewRecordsNotice => '記録が少ないため、まとめの一部が空になることがあります。';

  @override
  String get s5FgRefreshTitle => 'アプリ使用中に環境を更新';

  @override
  String get s5FgRefreshHint => 'アプリが開いている間、周辺を確認します。バックグラウンドでは動きません。';

  @override
  String get s5FieldDate => '日付';

  @override
  String get s5FieldMedication => '薬';

  @override
  String get s5FieldNote => 'メモ（任意）';

  @override
  String get s5FieldPuffs => '吸入回数（任意）';

  @override
  String get s5FieldReason => '使った理由（任意）';

  @override
  String get s5FieldTime => '時刻';

  @override
  String get s5FilterAll => 'すべて';

  @override
  String get s5FilterInhaler => '吸入器';

  @override
  String get s5FilterMedCheck => '服薬の確認';

  @override
  String get s5FilterSymptoms => '症状';

  @override
  String get s5FloodIssued => '洪水警報が発表されています';

  @override
  String get s5FloodNone => '発表中の洪水警報はありません';

  @override
  String get s5FloodUnknown => '警報を確認できません';

  @override
  String s5ForecastCheckedAt(String time) {
    return '確認時刻 $time';
  }

  @override
  String s5ForecastValidFor(String date) {
    return '$date の予報';
  }

  @override
  String get s5FromUrgentHelp => '緊急の助けから記録';

  @override
  String get s5HomeStateEmpty => '最初の記録を残しましょう。受診のときに伝える内容を一緒に整理できます。';

  @override
  String s5HomeStateQuestions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '医師に伝える質問が $n 件あります。',
    );
    return '$_temp0';
  }

  @override
  String s5HomeStateRecords(int n) {
    return '直近7日のうち、記録がある日：$n 日';
  }

  @override
  String get s5HomeSubtitle => '記録をまとめて、受診のときに見せられます。';

  @override
  String get s5HomeTitle => '今日の調子を記録しましょう';

  @override
  String s5HumidityValue(int rh) {
    return '屋外の湿度 $rh%';
  }

  @override
  String get s5IncludeEnvironment => '周辺の環境（任意）';

  @override
  String get s5IncludeEnvironmentHint => '今日の空気の質・花粉・洪水警報を加えます。詳しい位置は含めません。';

  @override
  String get s5InhalerEditTitle => '吸入器の使用の詳細';

  @override
  String get s5InhalerEntry => '吸入器の使用';

  @override
  String get s5InhalerLogged => '吸入器の使用を記録しました。';

  @override
  String get s5InhalerOneEntryHint => '1回の保存は使用記録 1 件です。1 吸入や 1 日として数えません。';

  @override
  String s5InhalerUnknownCount(int n) {
    return '薬の名前がわからない：$n 件';
  }

  @override
  String get s5InsCost => '費用の困りごと';

  @override
  String get s5InsDenial => '却下の理由（伝えられた場合）';

  @override
  String get s5InsMedHistory => '使ったことのある薬';

  @override
  String get s5InsuranceIntro => '医師の書類作成のために、情報を整理します。';

  @override
  String get s5InsuranceLimits => 'すべて任意です。このアプリは保険会社に何も送らず、承認の可否も判断しません。';

  @override
  String get s5InsuranceTitle => '保険の書類の準備';

  @override
  String s5LanguageName(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': '英語',
      'es': 'スペイン語',
      'fr': 'フランス語',
      'ko': '韓国語',
      'ja': '日本語',
      'zh': '中国語',
      'other': 'その他の言語',
    });
    return '$_temp0';
  }

  @override
  String get s5Last30Days => '直近30日';

  @override
  String get s5Last7Days => '直近7日';

  @override
  String get s5LogInhaler => '吸入器の使用を記録';

  @override
  String get s5LogLegend => '1 行は保存した記録 1 件です。記録がない日は「未記録」で、0 とは違います。';

  @override
  String get s5LogSymptoms => '症状を記録';

  @override
  String get s5MedAdd => '薬を追加';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return '使った $a 日 · 使っていない $b 日 · 覚えていない $c 日 · 未記録 $d 日';
  }

  @override
  String get s5MedCheckIntro => '薬を使ったかどうかを自分で確認する記録です。薬局の調剤データにもとづきません。';

  @override
  String get s5MedCheckQuestion => '予定どおり薬を使いましたか？';

  @override
  String get s5MedCheckTitle => '今日の服薬の確認';

  @override
  String get s5MedChooseHint => '薬を選ぶか、「薬の名前がわからない」を選んでください。';

  @override
  String get s5MedDailyCheck => '毎日の確認';

  @override
  String get s5MedDailyCheckHint =>
      'ホームに「今日の服薬の確認」を表示します。医師から毎日使うよう言われた薬のときだけオンにしてください。';

  @override
  String get s5MedDefault => 'すばやく記録するときの薬';

  @override
  String get s5MedDefaultHint => 'ホームで「吸入器の使用を記録」を押したときに使います。';

  @override
  String get s5MedEdit => '薬を編集';

  @override
  String get s5MedNameLabel => '薬の名前（ラベルの表記どおり）';

  @override
  String get s5MedNotApplicable => '今日は使う予定ではなかった';

  @override
  String s5MedNotApplicableDays(int n) {
    return '予定なし：$n 日';
  }

  @override
  String get s5MedNotRecorded => '薬は未記入';

  @override
  String get s5MedNotSure => '覚えていない';

  @override
  String get s5MedNotUsed => '使っていない';

  @override
  String get s5MedOther => '別の名前';

  @override
  String get s5MedOtherHint => '薬の名前を入力';

  @override
  String get s5MedReasonCost => '費用';

  @override
  String get s5MedReasonForgot => '忘れた';

  @override
  String get s5MedReasonNoMedicine => '薬がなかった';

  @override
  String get s5MedReasonQuestion => '理由（任意）';

  @override
  String get s5MedUnknown => '薬の名前がわからない';

  @override
  String get s5MedUnknownShort => '薬の名前がわからない';

  @override
  String get s5MedUsed => '使った';

  @override
  String get s5MyLanguage => '自分の言語';

  @override
  String get s5MyLogTitle => '自分の記録';

  @override
  String get s5MyMedsEmpty => '保存した薬はまだありません。';

  @override
  String get s5MyMedsHint => '自分で確認した薬の名前で、記録を速くします。用量の指示ではありません。';

  @override
  String get s5MyMedsOpen => '自分の薬を管理';

  @override
  String get s5MyMedsTitle => '自分の薬';

  @override
  String get s5NavEnvironment => '環境';

  @override
  String get s5NavLog => '記録';

  @override
  String get s5NavVisitPrep => '受診の準備';

  @override
  String get s5NoAnswer => '答えない';

  @override
  String get s5NoRecordsYet => 'まだ記録がありません';

  @override
  String s5NoSymptomDays(int n) {
    return '「症状なし」と記録した日：$n 日';
  }

  @override
  String get s5NotRecorded => '未記録';

  @override
  String get s5NotRecordedToday => '今日は未記録';

  @override
  String s5NotTranslatedLine(String language, String text) {
    return '[未翻訳 · 原文は$language] $text';
  }

  @override
  String get s5OsNotificationsOff =>
      '携帯電話の設定で Howse Asthma の通知がオフのため、通知は表示されません。';

  @override
  String get s5PdfAboutMedCheck =>
      '服薬の確認は患者本人の申告です。薬局の調剤データではなく、PDC（処方日数の割合）でもありません。';

  @override
  String get s5PdfAboutNoScore => '質問票の点数や、アプリが作ったリスク点数は含みません。';

  @override
  String get s5PdfAboutPatientReported =>
      'すべての記録は患者が Howse Asthma アプリに入力したもので、確認されていません。';

  @override
  String get s5PdfAppendix => '付録：患者のメモ';

  @override
  String s5PdfDaysNotRecorded(int n) {
    return '症状の記録がない日（未記録）：$n 日';
  }

  @override
  String get s5PdfDisclaimer => 'このまとめは、医師が確認するための患者申告の情報です。診断や事前承認の決定ではありません。';

  @override
  String get s5PdfEnvNote => 'まとめを作った時点の、一般的な屋外の環境です。位置は含みません。';

  @override
  String get s5PdfFailed => 'PDF を作成できませんでした。入力した内容は残しています。もう一度お試しください。';

  @override
  String get s5PdfFontFailed =>
      'PDF のフォントを準備できませんでした。インターネット接続を確認して、もう一度お試しください。';

  @override
  String s5PdfGeneratedAt(String time) {
    return '作成：$time';
  }

  @override
  String s5PdfInhalerByMed(String name, int n) {
    return '$name：$n 件';
  }

  @override
  String s5PdfInhalerMedNotRecorded(int n) {
    return '薬は未記入：$n 件';
  }

  @override
  String s5PdfInhalerUnknown(int n) {
    return '患者が薬の名前を知らなかった：$n 件';
  }

  @override
  String s5PdfInhalerUses(int n, int days) {
    return '吸入器の使用記録：$n 件（$days 日）';
  }

  @override
  String get s5PdfIsEnglish => 'PDF は英語で作成されます。自分で書いた文章はそのまま入ります。';

  @override
  String get s5PdfMedNamesAsEntered => '薬の名前は、患者が入力したとおりに表示します。';

  @override
  String get s5PdfNotRecorded => '未記録';

  @override
  String s5PdfNotUsedReason(String label, int n) {
    return '使わなかった理由（本人の申告）— $label：$n 日';
  }

  @override
  String get s5PdfOutdated =>
      '最後の PDF のあとで、記録や回答が変わりました。変更を入れるには PDF を作り直してください。';

  @override
  String s5PdfPeriod(String start, String end, int days) {
    return '期間：$start – $end（$days 日）';
  }

  @override
  String s5PdfReasonCount(String label, int n) {
    return '使った理由 — $label：$n 件';
  }

  @override
  String s5PdfRecordedDays(int n) {
    return '患者の記録がある日：$n 日';
  }

  @override
  String get s5PdfSectionAboutData => 'このデータの性質';

  @override
  String get s5PdfSectionBarriers => '治療を受けるうえでの困りごと（本人の申告）';

  @override
  String get s5PdfSectionEnvironment => '周辺の環境（参考）';

  @override
  String get s5PdfSectionInhaler => '吸入器の使用';

  @override
  String get s5PdfSectionInsurance => '書類用のメモ（患者が記入）';

  @override
  String get s5PdfSectionMedChecks => '本人が申告した服薬';

  @override
  String get s5PdfSectionQuestions => '患者からの質問';

  @override
  String get s5PdfSectionSymptoms => '症状';

  @override
  String s5PdfSymptomCodeDays(String label, int n) {
    return '$label：$n 日';
  }

  @override
  String s5PdfSymptomDays(int n, int days) {
    return '症状があった日：$days 日中 $n 日';
  }

  @override
  String s5PdfSymptomOtherDays(int n) {
    return '患者が自分で書いたその他の症状：$n 日';
  }

  @override
  String get s5PdfTitle => '患者が申告したぜんそく受診のまとめ';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return '期間 $days 日 · 記録がある日 $n 日';
  }

  @override
  String get s5PhoneHint => '国番号を含めて入力してください。例：+1 201 555 0123';

  @override
  String get s5PhoneInvalid => '名前と、国番号を含む電話番号を入力してください。例：+1 201 555 0123';

  @override
  String get s5PollenGrass => 'イネ科';

  @override
  String s5PollenMainType(String type) {
    return '主な種類：$type';
  }

  @override
  String get s5PollenTree => '樹木';

  @override
  String get s5PollenWeed => '雑草';

  @override
  String get s5PrepareVisit => '受診の準備をする';

  @override
  String get s5PreviewEditHint =>
      '質問やメモは前の画面で直せます。数字を直すには、自分の記録で元の記録を編集してください。';

  @override
  String get s5PreviewSummary => '受診のまとめを見る';

  @override
  String get s5PreviewTitle => '受診のまとめのプレビュー';

  @override
  String s5PuffsValue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 吸入',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return '質問 $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return '質問 $n/$total';
  }

  @override
  String get s5ReasonBeforeActivity => '活動の前';

  @override
  String get s5ReasonOther => 'その他';

  @override
  String get s5ReasonSymptoms => '症状のため';

  @override
  String s5RecentInhaler(int n) {
    return '吸入器の使用記録 $n 件';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return '症状があった日 $n 日';
  }

  @override
  String get s5RecentTitle => '直近7日';

  @override
  String get s5RecordsLoadFailed => '記録を読み込めませんでした。もう一度お試しください。';

  @override
  String get s5RecordsManageHint => '記録は「自分の記録」で編集または削除できます。削除の前には必ず確認します。';

  @override
  String get s5Refresh => '更新';

  @override
  String get s5Reload => '再読み込み';

  @override
  String get s5Save => '保存';

  @override
  String get s5Saved => '保存しました。';

  @override
  String get s5SavedPlacesHint => '自宅、学校、職場など、保存した場所';

  @override
  String get s5SaveFailed => '保存できませんでした。入力した内容は残しています。';

  @override
  String get s5SavePdf => 'PDF を保存';

  @override
  String get s5SettingsAlerts => '通知';

  @override
  String get s5SettingsArea => '地域';

  @override
  String get s5SettingsHelp => 'ヘルプ';

  @override
  String get s5SettingsLanguageNote => '受診のまとめは英語で作られます。共有する前に、自分の言語と見比べられます。';

  @override
  String get s5SettingsSecurityData => 'セキュリティとデータ';

  @override
  String get s5Share => '共有';

  @override
  String get s5SourcesAir => '空気の質：EPA AirNow、Open-Meteo、PurpleAir';

  @override
  String get s5SourcesFlood => '洪水警報：米国国立気象局';

  @override
  String get s5SourcesNjTraffic => '交通量のデータはニュージャージー州でのみ使います。';

  @override
  String get s5SourcesNoRiskScore => 'アプリ内部の総合点数はぜんそく発作のリスクではなく、表示しません。';

  @override
  String get s5SourcesPollen => '花粉：Google Pollen API';

  @override
  String get s5SourcesTitle => '出典と限界';

  @override
  String get s5SourcesWeather => '天気・湿度：Open-Meteo';

  @override
  String get s5StatusLatest => '最新';

  @override
  String get s5StatusOlder => '以前のデータ';

  @override
  String get s5StatusUnavailable => 'いまは確認できません';

  @override
  String get s5SymActivityLimited => '活動が制限された';

  @override
  String get s5SymCough => 'せき';

  @override
  String get s5SymNightWaking => '夜に目が覚めた';

  @override
  String get s5SymNone => '症状なし';

  @override
  String get s5SymOther => '自分で書く';

  @override
  String get s5SymOtherHint => '自分の言葉で書いてください';

  @override
  String get s5SymShortBreath => '息が苦しい';

  @override
  String get s5SymWheeze => 'ぜーぜーする';

  @override
  String get s5SymptomEditTitle => '症状を編集';

  @override
  String get s5SymptomEntry => '症状';

  @override
  String get s5SymptomNoneHint => '記録しなかった日は「症状なし」ではなく「未記録」と表示されます。';

  @override
  String get s5SymptomQuestion => 'どんな症状がありましたか？';

  @override
  String get s5Today => '今日';

  @override
  String get s5Undo => '元に戻す';

  @override
  String s5UntranslatedNotice(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n 件は翻訳されていません。英語の PDF には原文のまま、「Not translated」の表示とともに入ります。原文を確認してください。',
    );
    return '$_temp0';
  }

  @override
  String s5UpdatedAt(String time) {
    return '更新 $time';
  }

  @override
  String get s5UpiHigh => '高い';

  @override
  String get s5UpiLow => '低い';

  @override
  String get s5UpiModerate => '普通';

  @override
  String get s5UpiNone => 'なし';

  @override
  String s5UpiValue(int upi, String category) {
    return '5 のうち $upi · $category';
  }

  @override
  String get s5UpiVeryHigh => '非常に高い';

  @override
  String get s5UpiVeryLow => '非常に低い';

  @override
  String get s5UrgentActionPlan => '医師からもらったぜんそくの行動計画があれば、それに従ってください。';

  @override
  String get s5UrgentCall911Locked => '緊急の助け：911 に電話';

  @override
  String get s5UrgentHelp => '緊急の助け';

  @override
  String get s5UrgentIntro => '息をするのがとても苦しい、または良くならないときは、911 に電話してください。';

  @override
  String get s5UrgentLogHint => '任意：吸入器を使ったという記録を残せます。';

  @override
  String get s5UrgentNoContact => '緊急連絡先がまだありません。設定 → ヘルプで追加してください。';

  @override
  String s5UsingMedication(String name) {
    return '記録する薬：$name';
  }

  @override
  String get s5ViewMyLog => '自分の記録を見る';

  @override
  String get s5VisitBarriers => '治療を受けるのに困ったことはありましたか？';

  @override
  String s5VisitCardDetail(int days, int recorded, int questions) {
    return '直近 $days 日 · 記録がある日 $recorded 日 · 質問 $questions 件';
  }

  @override
  String get s5VisitCardTitle => '受診のときに伝える内容';

  @override
  String get s5VisitInclude => '含める記録';

  @override
  String get s5VisitIntro => '症状と聞きたいことを整理して、医師に見せましょう。';

  @override
  String get s5VisitPeriod => 'まとめの期間';

  @override
  String get s5VisitPrepTitle => '受診の準備';

  @override
  String get s5VisitQuestions => '医師に聞きたいこと';

  @override
  String get s5VisitQuestionsHint => '自分の言語で書いてください。空欄でもかまいません。';

  @override
  String get s6AddTime => '時刻を追加';

  @override
  String get s6AddVisit => '自分で報告した受診を追加';

  @override
  String get s6BringPaper => '書類を持っていく';

  @override
  String get s6BringPaperHint => '書類があることは、医療者が確認したという意味ではありません。';

  @override
  String s6DaySummary(
    String date,
    int used,
    int scheduled,
    int open,
    int symptoms,
    String env,
  ) {
    return '$date · 確認 $used/$scheduled · 未回答 $open · 症状 $symptoms · $env';
  }

  @override
  String get s6DoseLater => 'あとで確認';

  @override
  String get s6DoseNotUsed => '使えませんでした';

  @override
  String get s6DoseUnconfirmed => 'まだ回答なし';

  @override
  String get s6DoseUsed => '使いました';

  @override
  String get s6EnvLinked => '環境を接続済み';

  @override
  String get s6EnvNoData => 'その時刻の環境データなし';

  @override
  String get s6EvidenceBody => '医療者が確認する記録と、まだ足りない情報を整理します。';

  @override
  String get s6EvidenceNotOfficial => '一般的な資料の一覧です。特定の保険の公式な要件一覧ではありません。';

  @override
  String get s6EvidenceTitle => '受診・保険審査のための資料準備';

  @override
  String get s6HideMedName => 'ロック画面で薬の名前を隠す';

  @override
  String get s6HideMedNameHint => '通知は保存した服用時刻だけに来ます。30分ごとの通知ではありません。';

  @override
  String get s6HomeWaterNo => 'いいえ';

  @override
  String get s6HomeWaterQuestion => '家で水漏れや浸水はありましたか？';

  @override
  String get s6HomeWaterYes => 'はい';

  @override
  String get s6ItemClinician => '医療者の確認、または持参する資料';

  @override
  String get s6ItemEnvironment => '出来事の時刻の地域の環境参考';

  @override
  String get s6ItemMedication => '薬の名前と処方内容';

  @override
  String get s6ItemSymptoms => '続いている症状と日常生活の制限';

  @override
  String get s6ItemUse => '使用期間と、自分で確認した使用記録';

  @override
  String get s6ItemVisits => '自分で報告した受診・救急';

  @override
  String get s6NoSchedule => '保存した服用時刻はまだありません。自分の薬で追加してください。';

  @override
  String get s6OccurredLabel => '起きた時刻';

  @override
  String get s6PdfEnvLimit =>
      '地域の参考です。個人の曝露や症状の原因は示しません。AQI の値ひとつでオゾンと粒子の両方は言わず、花粉は含みません。';

  @override
  String get s6PdfEnvTitle => '環境の参考（付録）';

  @override
  String get s6PuffsEach => '1回の吸入回数';

  @override
  String s6ReminderBodyNamed(String name) {
    return '$name の使用を確認';
  }

  @override
  String get s6ReminderBodyPrivate => '薬の使用を確認';

  @override
  String get s6ReminderChannel => '保存した服用時刻の通知です。30分ごとの通知ではありません。';

  @override
  String get s6ReminderTitle => '薬の使用確認';

  @override
  String get s6RoleBoth => '毎日と必要なとき';

  @override
  String get s6RoleController => '毎日の薬';

  @override
  String get s6RoleRescue => '必要なとき';

  @override
  String get s6ScheduleTimes => '服用する時刻';

  @override
  String get s6StatusClinician => '医療者の確認が必要';

  @override
  String get s6StatusNeedInfo => '情報の追加が必要';

  @override
  String get s6StatusRecorded => '記録あり';

  @override
  String get s6TimelineTitle => '治療と環境';

  @override
  String get s6TodayDoses => '今日確認する薬';

  @override
  String get s6VisitKindEr => '救急（自分で報告）';

  @override
  String get s6VisitKindOffice => '外来（自分で報告）';

  @override
  String get s6VisitKindOther => 'その他の受診（自分で報告）';

  @override
  String get s6VisitKindUrgent => '緊急診療（自分で報告）';
}
