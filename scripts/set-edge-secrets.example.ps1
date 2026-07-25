# Example template for WBS 1.7 (safe to commit — no real secrets).
# Copy to set-edge-secrets.ps1 (gitignored) or use the generated local script.

$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

$secrets = [ordered]@{
    AIRNOW_API_KEY           = "YOUR_AIRNOW_API_KEY"
    PURPLEAIR_READ_KEY       = "YOUR_PURPLEAIR_READ_KEY"
    GOOGLE_MAPS_API_KEY      = "YOUR_GOOGLE_MAPS_API_KEY"
    NWS_USER_AGENT_CONTACT   = "contact@howseasthma.com"
    RESEND_API_KEY           = "YOUR_RESEND_API_KEY"
    RESEND_FROM_EMAIL        = "noreply@howseasthma.com"
    RESEND_REPLY_TO          = "contact@howseasthma.com"
    EFAX_ENABLED             = "false"
}

$argsList = @()
foreach ($name in $secrets.Keys) {
    $argsList += "$name=$($secrets[$name])"
}
supabase secrets set @argsList
