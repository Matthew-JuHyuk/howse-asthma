/**
 * Merge Sprint 2 Direction C strings into l10n overlays.
 * Run: node tool/merge_sprint2_l10n.mjs && node tool/apply_l10n_translations.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const overlaysDir = path.join(__dirname, "l10n_overlays");

const tr = {
  appTagline: {
    es: "Tu escudo inteligente contra los desencadenantes",
    fr: "Votre bouclier intelligent contre les declencheurs",
    ko: "환경 자극으로부터 호흡을 지키는 스마트한 울타리",
    ja: "トリガーから守るスマートなシールド",
    zh: "抵御诱发因素的智能防护盾",
  },
  welcomeBenefit1: {
    es: "Alertas proactivas de calidad del aire y polen",
    fr: "Alertes proactives qualite de l air et pollen",
    ko: "실시간 환경 위험(AQI·꽃가루) 선제 예측 및 알림",
    ja: "大気質・花粉リスクの先回りアラート",
    zh: "空气质量与花粉风险的主动预警",
  },
  welcomeBenefit2: {
    es: "Check-in diario de 3 segundos para tu respiracion",
    fr: "Un check-in quotidien de 3 secondes",
    ko: "3초 만에 끝나는 매일의 호흡 주도권 체크",
    ja: "3秒でできる毎日の呼吸チェック",
    zh: "每日3秒呼吸自主检查",
  },
  welcomeBenefit3: {
    es: "Informes de datos confiables para tu clinico",
    fr: "Rapports fiables a partager avec votre clinicien",
    ko: "의사와 공유하는 신뢰할 수 있는 데이터 리포트",
    ja: "医師と共有できる信頼できるデータレポート",
    zh: "可与医生共享的可信数据报告",
  },
  welcomeContinueEmail: {
    es: "o continuar con correo",
    fr: "ou continuer avec e-mail",
    ko: "또는 이메일로 시작하기",
    ja: "またはメールで続ける",
    zh: "或使用邮箱继续",
  },
  welcomeTermsAgree: {
    es: "Acepto los Terminos y la Politica de privacidad",
    fr: "J accepte les Conditions et la Politique de confidentialite",
    ko: "이용약관 및 개인정보 처리방침에 동의합니다",
    ja: "利用規約とプライバシーポリシーに同意します",
    zh: "我同意服务条款与隐私政策",
  },
  welcomeTermsPending: {
    es: "Los enlaces legales estaran disponibles cuando se publiquen.",
    fr: "Les liens juridiques seront disponibles une fois publies.",
    ko: "약관 링크는 게시 후 제공됩니다.",
    ja: "法務リンクは公開後に利用できます。",
    zh: "法律文件链接将在发布后提供。",
  },
  welcomeClinicianLink: {
    es: "Soy profesional de la salud",
    fr: "Je suis clinicien",
    ko: "의료진입니다",
    ja: "医療従事者です",
    zh: "我是临床医护人员",
  },
  checkInWelcomeHome: {
    es: "Bienvenido a casa!",
    fr: "Bienvenue chez vous !",
    ko: "Welcome Home!",
    ja: "おかえりなさい！",
    zh: "欢迎回家！",
  },
  checkInQuestion: {
    es: "Como esta tu respiracion ahora?",
    fr: "Comment respirez-vous en ce moment ?",
    ko: "지금 호흡 상태는 어떤가요?",
    ja: "今の呼吸の状態は？",
    zh: "您现在的呼吸状况如何？",
  },
  checkInBreathUsual: {
    es: "Como de costumbre",
    fr: "Comme d habitude",
    ko: "평소와 같음",
    ja: "いつもどおり",
    zh: "与平时差不多",
  },
  checkInBreathTight: {
    es: "Un poco apretada",
    fr: "Un peu serree",
    ko: "약간 답답함",
    ja: "少し苦しい",
    zh: "有点闷",
  },
  checkInBreathSymptoms: {
    es: "Tengo sintomas",
    fr: "J ai des symptomes",
    ko: "증상 있음",
    ja: "症状がある",
    zh: "有症状",
  },
  checkInAeroPoints: {
    es: "Primer check-in listo! +5 AeroPoints",
    fr: "Premier check-in termine ! +5 AeroPoints",
    ko: "첫 체크인 완료! +5 AeroPoint",
    ja: "初回チェックイン完了！+5 AeroPoints",
    zh: "首次签到完成！+5 AeroPoints",
  },
  shieldLocationTitle: {
    es: "Activa tu escudo preventivo",
    fr: "Activez votre bouclier preventif",
    ko: "선제적 울타리를 활성화하세요",
    ja: "先制シールドを有効にする",
    zh: "启用您的预先防护盾",
  },
  shieldLocationBody: {
    es: "Activa el escudo a tu alrededor: necesitamos la ubicacion para aire y polen cercanos.",
    fr: "Activez le bouclier autour de vous — la localisation est necessaire pour l air et le pollen.",
    ko: "당신 주위의 선제적 울타리를 활성화하려면 위치가 필요합니다.",
    ja: "周囲の先制シールドを有効にするため位置情報が必要です。",
    zh: "开启周围预先防护需要位置信息以获取附近空气与花粉。",
  },
  shieldLocationAllow: {
    es: "Permitir ubicacion",
    fr: "Autoriser la localisation",
    ko: "위치 허용",
    ja: "位置情報を許可",
    zh: "允许位置",
  },
  shieldLocationNotNow: {
    es: "Ahora no",
    fr: "Pas maintenant",
    ko: "나중에",
    ja: "今はしない",
    zh: "暂不",
  },
  splashTagline: {
    es: "Tu escudo inteligente contra los desencadenantes",
    fr: "Votre bouclier intelligent contre les declencheurs",
    ko: "환경 자극으로부터 호흡을 지키는 스마트한 울타리",
    ja: "トリガーから守るスマートなシールド",
    zh: "抵御诱发因素的智能防护盾",
  },
};

for (const lang of ["es", "fr", "ko", "ja", "zh"]) {
  const p = path.join(overlaysDir, `${lang}.json`);
  const o = JSON.parse(fs.readFileSync(p, "utf8"));
  for (const [k, v] of Object.entries(tr)) {
    o[k] = v[lang];
  }
  fs.writeFileSync(p, JSON.stringify(o, null, 2) + "\n");
  console.log("ok", lang);
}
