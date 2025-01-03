$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# GitHub API URL for latest release
$githubApiUrl = "https://api.github.com/repos/rclone/rclone/releases/latest"

# Check if 'gh' command is available
if (Get-Command gh -ErrorAction SilentlyContinue) {
  # If 'gh' is available, use it to fetch the latest version
  if ($env:version -eq 'latest') {
    $latest_version = (gh api repos/rclone/rclone/releases/latest -q .tag_name)
    Add-Content $env:GITHUB_OUTPUT "version=$latest_version"
  } else {
    Add-Content $env:GITHUB_OUTPUT "version=$env:version"
  }
} else {
  # If 'gh' is not available, fall back to using REST API to fetch the latest version
  if ($env:version -eq 'latest') {
    $response = Invoke-RestMethod -Uri $githubApiUrl -Method Get -Headers @{Accept = 'application/vnd.github.v3+json' }
    $latest_version = $response.tag_name
    Add-Content $env:GITHUB_OUTPUT "version=$latest_version"
  } else {
    Add-Content $env:GITHUB_OUTPUT "version=$env:version"
  }
}

# Write-Output $latest_version
