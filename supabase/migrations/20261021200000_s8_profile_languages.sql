-- Sprint 8: widen profiles.language_code to the languages the app offers.
--
-- Additive only: no table or column is dropped or renamed. The old CHECK
-- allowed en/es/fr/ko/ja/zh; the app now stores BCP-47 tags for the New
-- Jersey language set (en, es, pt, ko, gu, zh-Hans, zh-Hant, ht, ar). The
-- earlier values stay valid so existing rows are not touched.

DO $$
DECLARE
  c record;
BEGIN
  FOR c IN
    SELECT con.conname
    FROM pg_constraint con
    JOIN pg_class rel ON rel.oid = con.conrelid
    JOIN pg_namespace ns ON ns.oid = rel.relnamespace
    WHERE ns.nspname = 'public'
      AND rel.relname = 'profiles'
      AND con.contype = 'c'
      AND pg_get_constraintdef(con.oid) ILIKE '%language_code%'
  LOOP
    EXECUTE format('ALTER TABLE public.profiles DROP CONSTRAINT %I', c.conname);
  END LOOP;
END
$$;

ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_language_code_check
  CHECK (
    language_code IN (
      'en', 'es', 'pt', 'ko', 'gu', 'zh-Hans', 'zh-Hant', 'ht', 'ar',
      'fr', 'ja', 'zh'
    )
  );
