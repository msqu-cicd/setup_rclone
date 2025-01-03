$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
Set-StrictMode -Version Latest
Write-Host ::group::Downloading Rclone $env:version for Windows
if ($null -ne $env:GITEA_ACTIONS -and $env:GITEA_ACTIONS -ne "") {
    Invoke-WebRequest https://github.com/rclone/rclone/releases/download/$env:version/rclone-$env:version-windows-amd64.zip -OutFile rclone-$env:version-windows-amd64.zip
} else {
    Invoke-WebRequest $env:GITHUB_SERVER_URL/rclone/rclone/releases/download/$env:version/rclone-$env:version-windows-amd64.zip -OutFile rclone-$env:version-windows-amd64.zip
}
Expand-Archive rclone-$env:version-windows-amd64.zip Rclone
Move-Item Rclone\rclone-$env:version-windows-amd64\* Rclone
Remove-Item rclone-$env:version-windows-amd64.zip, Rclone\rclone-$env:version-windows-amd64
Write-Host ::endgroup::
