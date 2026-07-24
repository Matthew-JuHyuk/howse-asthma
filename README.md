# Howse Asthma

Flutter app for asthma patients: predicts attack risk from local weather/air-quality data and sends early warnings, while logging inhaler/medication use as evidence for insurance step-therapy approval. Multilingual (EN/ES/FR/KO/JA/ZH) to lower barriers for underserved, non-native-English patients & families. Android/iOS, Supabase backend.

## Tech stack

- [Flutter](https://flutter.dev/) (stable channel) — Android, iOS, and Windows (for early PC-based development)
- [Supabase](https://supabase.com/) — authentication and database
- `flutter_localizations` + ARB files for multilingual support (English, Spanish, French, Korean, Japanese, Chinese)

## Getting started

```powershell
git clone https://github.com/Matthew-JuHyuk/howse-asthma.git
cd howse-asthma
flutter pub get
Copy-Item .env.example .env   # then fill in your Supabase project URL/anon key
flutter run -d windows        # or connect an Android device and run `flutter run`
```

## License

Apache License 2.0 — see [LICENSE](LICENSE).
