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
  String get splashTagline => 'すべての家族のための、よりスマートな喘息予防。';

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
}
