locals {
  job_schedules = {
    "jellyfin-recently-added-scan" = "0 */5 * * * *"
    "jellyfin-full-scan"           = "0 0 3 * * *"
    "radarr-scan"                  = "0 0 4 * * *"
    "sonarr-scan"                  = "0 30 4 * * *"
    "availability-sync"            = "0 0 5 * * *"
    "download-sync"                = "0 * * * * *"
    "download-sync-reset"          = "0 0 1 * * *"
    "image-cache-cleanup"          = "0 0 5 * * *"
    "process-blocklisted-tags"     = "0 30 1 */7 * *"
  }
}

resource "seerr_job_schedule" "this" {
  for_each = local.job_schedules

  job_id   = each.key
  schedule = each.value
}
