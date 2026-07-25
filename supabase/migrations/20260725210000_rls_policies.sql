-- Howse Asthma — RLS policies (WBS 1.4)
-- Source: docs/db-schema.md §3
-- Prerequisite: 20260725200000_init_schema.sql (tables + RLS enabled)

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.is_active_provider_of(p_patient UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.patient_care_links l
    WHERE l.patient_id = p_patient
      AND l.provider_id = auth.uid()
      AND l.status = 'active'
  );
$$;

REVOKE ALL ON FUNCTION public.is_active_provider_of(UUID) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_active_provider_of(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION public.is_active_provider_of(UUID) TO service_role;

-- ---------------------------------------------------------------------------
-- profiles
-- ---------------------------------------------------------------------------

CREATE POLICY profiles_select_own
  ON public.profiles FOR SELECT TO authenticated
  USING (id = auth.uid());

CREATE POLICY profiles_select_linked_patient
  ON public.profiles FOR SELECT TO authenticated
  USING (public.is_active_provider_of(id));

CREATE POLICY profiles_insert_own
  ON public.profiles FOR INSERT TO authenticated
  WITH CHECK (id = auth.uid());

CREATE POLICY profiles_update_own
  ON public.profiles FOR UPDATE TO authenticated
  USING (id = auth.uid())
  WITH CHECK (id = auth.uid());

-- ---------------------------------------------------------------------------
-- provider_credentials
-- ---------------------------------------------------------------------------

CREATE POLICY provider_credentials_all_own
  ON public.provider_credentials FOR ALL TO authenticated
  USING (provider_id = auth.uid())
  WITH CHECK (provider_id = auth.uid());

-- ---------------------------------------------------------------------------
-- patient_details
-- ---------------------------------------------------------------------------

CREATE POLICY patient_details_select_own
  ON public.patient_details FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY patient_details_select_linked_provider
  ON public.patient_details FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY patient_details_insert_own
  ON public.patient_details FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY patient_details_update_own
  ON public.patient_details FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- invite_codes (provider issued only; patient redeem via Edge/RPC)
-- ---------------------------------------------------------------------------

CREATE POLICY invite_codes_select_own
  ON public.invite_codes FOR SELECT TO authenticated
  USING (provider_id = auth.uid());

CREATE POLICY invite_codes_insert_own
  ON public.invite_codes FOR INSERT TO authenticated
  WITH CHECK (provider_id = auth.uid());

CREATE POLICY invite_codes_update_own
  ON public.invite_codes FOR UPDATE TO authenticated
  USING (provider_id = auth.uid())
  WITH CHECK (provider_id = auth.uid());

CREATE POLICY invite_codes_delete_own
  ON public.invite_codes FOR DELETE TO authenticated
  USING (provider_id = auth.uid());

-- ---------------------------------------------------------------------------
-- patient_care_links
-- ---------------------------------------------------------------------------

CREATE POLICY care_links_select_participant
  ON public.patient_care_links FOR SELECT TO authenticated
  USING (patient_id = auth.uid() OR provider_id = auth.uid());

CREATE POLICY care_links_insert_as_provider
  ON public.patient_care_links FOR INSERT TO authenticated
  WITH CHECK (provider_id = auth.uid());

CREATE POLICY care_links_insert_as_patient
  ON public.patient_care_links FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY care_links_update_as_patient
  ON public.patient_care_links FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY care_links_update_as_provider
  ON public.patient_care_links FOR UPDATE TO authenticated
  USING (provider_id = auth.uid())
  WITH CHECK (provider_id = auth.uid());

-- ---------------------------------------------------------------------------
-- saved_locations
-- ---------------------------------------------------------------------------

CREATE POLICY saved_locations_all_own
  ON public.saved_locations FOR ALL TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY saved_locations_select_linked_provider
  ON public.saved_locations FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

-- ---------------------------------------------------------------------------
-- notification_preferences
-- ---------------------------------------------------------------------------

CREATE POLICY notification_prefs_all_own
  ON public.notification_preferences FOR ALL TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- device_push_tokens
-- ---------------------------------------------------------------------------

CREATE POLICY device_push_tokens_all_own
  ON public.device_push_tokens FOR ALL TO authenticated
  USING (profile_id = auth.uid())
  WITH CHECK (profile_id = auth.uid());

-- ---------------------------------------------------------------------------
-- emergency_contacts
-- ---------------------------------------------------------------------------

CREATE POLICY emergency_contacts_all_own
  ON public.emergency_contacts FOR ALL TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY emergency_contacts_select_linked_provider
  ON public.emergency_contacts FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

-- ---------------------------------------------------------------------------
-- environment_forecasts (read for authenticated; write = service_role only)
-- ---------------------------------------------------------------------------

CREATE POLICY environment_forecasts_select_authenticated
  ON public.environment_forecasts FOR SELECT TO authenticated
  USING (true);

-- ---------------------------------------------------------------------------
-- environment_alerts_sent (patient read own; provider read linked; write = Edge)
-- ---------------------------------------------------------------------------

CREATE POLICY alerts_sent_select_own
  ON public.environment_alerts_sent FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY alerts_sent_select_linked_provider
  ON public.environment_alerts_sent FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

-- ---------------------------------------------------------------------------
-- inhaler_events
-- ---------------------------------------------------------------------------

CREATE POLICY inhaler_events_select_own
  ON public.inhaler_events FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY inhaler_events_select_linked_provider
  ON public.inhaler_events FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY inhaler_events_insert_own
  ON public.inhaler_events FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY inhaler_events_update_own
  ON public.inhaler_events FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY inhaler_events_delete_own
  ON public.inhaler_events FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- act_assessments
-- ---------------------------------------------------------------------------

CREATE POLICY act_assessments_select_own
  ON public.act_assessments FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY act_assessments_select_linked_provider
  ON public.act_assessments FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY act_assessments_insert_own
  ON public.act_assessments FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY act_assessments_update_own
  ON public.act_assessments FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY act_assessments_delete_own
  ON public.act_assessments FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- pdc_daily_checks
-- ---------------------------------------------------------------------------

CREATE POLICY pdc_checks_select_own
  ON public.pdc_daily_checks FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY pdc_checks_select_linked_provider
  ON public.pdc_daily_checks FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY pdc_checks_insert_own
  ON public.pdc_daily_checks FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY pdc_checks_update_own
  ON public.pdc_daily_checks FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY pdc_checks_delete_own
  ON public.pdc_daily_checks FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- panic_episodes (patient R/W; provider read linked)
-- ---------------------------------------------------------------------------

CREATE POLICY panic_episodes_select_own
  ON public.panic_episodes FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY panic_episodes_select_linked_provider
  ON public.panic_episodes FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY panic_episodes_insert_own
  ON public.panic_episodes FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY panic_episodes_update_own
  ON public.panic_episodes FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY panic_episodes_delete_own
  ON public.panic_episodes FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- pa_documents
-- ---------------------------------------------------------------------------

CREATE POLICY pa_documents_select_own_patient
  ON public.pa_documents FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY pa_documents_select_own_provider
  ON public.pa_documents FOR SELECT TO authenticated
  USING (provider_id = auth.uid());

CREATE POLICY pa_documents_insert_provider_linked
  ON public.pa_documents FOR INSERT TO authenticated
  WITH CHECK (
    provider_id = auth.uid()
    AND public.is_active_provider_of(patient_id)
  );

CREATE POLICY pa_documents_update_own_provider
  ON public.pa_documents FOR UPDATE TO authenticated
  USING (provider_id = auth.uid())
  WITH CHECK (
    provider_id = auth.uid()
    AND public.is_active_provider_of(patient_id)
  );

CREATE POLICY pa_documents_delete_own_provider
  ON public.pa_documents FOR DELETE TO authenticated
  USING (provider_id = auth.uid());

-- ---------------------------------------------------------------------------
-- signature_artifacts
-- ---------------------------------------------------------------------------

CREATE POLICY signature_artifacts_select_provider
  ON public.signature_artifacts FOR SELECT TO authenticated
  USING (provider_id = auth.uid());

CREATE POLICY signature_artifacts_select_patient_via_doc
  ON public.signature_artifacts FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM public.pa_documents d
      WHERE d.id = signature_artifacts.pa_document_id
        AND d.patient_id = auth.uid()
    )
  );

CREATE POLICY signature_artifacts_insert_provider
  ON public.signature_artifacts FOR INSERT TO authenticated
  WITH CHECK (provider_id = auth.uid());

CREATE POLICY signature_artifacts_delete_provider
  ON public.signature_artifacts FOR DELETE TO authenticated
  USING (provider_id = auth.uid());

-- ---------------------------------------------------------------------------
-- outbound_transmissions (client: queue/read; status updates via Edge)
-- ---------------------------------------------------------------------------

CREATE POLICY outbound_select_provider
  ON public.outbound_transmissions FOR SELECT TO authenticated
  USING (provider_id = auth.uid());

CREATE POLICY outbound_select_patient_via_doc
  ON public.outbound_transmissions FOR SELECT TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM public.pa_documents d
      WHERE d.id = outbound_transmissions.pa_document_id
        AND d.patient_id = auth.uid()
    )
  );

CREATE POLICY outbound_insert_provider
  ON public.outbound_transmissions FOR INSERT TO authenticated
  WITH CHECK (
    provider_id = auth.uid()
    AND status = 'QUEUED'
  );

-- ---------------------------------------------------------------------------
-- point_transactions / conversions / redemptions (SELECT own; INSERT = Edge)
-- ---------------------------------------------------------------------------

CREATE POLICY point_transactions_select_own
  ON public.point_transactions FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY point_to_donation_select_own
  ON public.point_to_donation_conversions FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY voucher_redemptions_select_own
  ON public.voucher_redemptions FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- food_bank_vouchers (catalog read for authenticated)
-- ---------------------------------------------------------------------------

CREATE POLICY food_bank_vouchers_select_authenticated
  ON public.food_bank_vouchers FOR SELECT TO authenticated
  USING (true);

-- ---------------------------------------------------------------------------
-- donation_transactions (SELECT own; INSERT = Edge/webhook)
-- ---------------------------------------------------------------------------

CREATE POLICY donation_transactions_select_own
  ON public.donation_transactions FOR SELECT TO authenticated
  USING (donor_profile_id = auth.uid());
