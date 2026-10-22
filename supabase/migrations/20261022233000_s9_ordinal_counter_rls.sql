-- Case numbers are assigned while a letter is uploaded. The counter table has
-- row level security and no client policy, so an invoker insert is rejected
-- (42501) and the app shows "forbidden". The definer function writes the row.
-- Clients still cannot read or change counters.

CREATE OR REPLACE FUNCTION public.next_case_ordinal(p_owner UUID)
RETURNS INTEGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    n INTEGER;
BEGIN
    IF p_owner IS NULL OR p_owner IS DISTINCT FROM auth.uid() THEN
        RAISE EXCEPTION 'forbidden' USING ERRCODE = '42501';
    END IF;
    INSERT INTO public.case_ordinal_counters (owner_id, next_ordinal)
    VALUES (p_owner, 1)
    ON CONFLICT (owner_id) DO UPDATE
        SET next_ordinal = public.case_ordinal_counters.next_ordinal + 1
    RETURNING next_ordinal INTO n;
    RETURN n;
END;
$$;

REVOKE ALL ON FUNCTION public.next_case_ordinal(UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.next_case_ordinal(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.next_case_ordinal(UUID) TO service_role;

ALTER TABLE public.case_ordinal_counters ENABLE ROW LEVEL SECURITY;
