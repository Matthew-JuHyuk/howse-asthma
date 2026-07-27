# Example template (safe to commit — no real secrets).
# Copy to set-edge-secrets.ps1 and replace placeholders, or run equivalent CLI commands.

$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

$secrets = [ordered]@{
    AIRNOW_API_KEY           = "YOUR_AIRNOW_API_KEY"
    PURPLEAIR_READ_KEY       = "YOUR_PURPLEAIR_READ_KEY"
    GOOGLE_MAPS_API_KEY      = "YOUR_GOOGLE_MAPS_API_KEY"
    NWS_USER_AGENT_CONTACT   = "YOUR_CONTACT_EMAIL"
    RESEND_API_KEY           = "YOUR_RESEND_API_KEY"
    RESEND_FROM_EMAIL        = "YOUR_RESEND_FROM_EMAIL"
    RESEND_REPLY_TO          = "YOUR_RESEND_REPLY_TO"
    EFAX_ENABLED             = "false"
    # Firebase service account JSON as a single-line string (WBS 4.6a FCM).
    # Prefer: supabase secrets set FIREBASE_SERVICE_ACCOUNT_JSON --env-file ...
    # Do not commit the real JSON.
    # FIREBASE_SERVICE_ACCOUNT_JSON = '{"type":"service_account",...}'
}

$argsList = @()
foreach ($name in $secrets.Keys) {
    $argsList += "$name=$($secrets[$name])"
}
supabase secrets set @argsList
