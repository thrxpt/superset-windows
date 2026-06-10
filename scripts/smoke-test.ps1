<#
.SYNOPSIS
    Smoke test for the packaged Superset Windows build.
    Launches the exe, waits, and asserts the process is still alive
    (i.e. no startup crash). Kills the process tree afterwards.
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$ExePath,

    [int]$WaitSeconds = 30
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $ExePath)) {
    Write-Error "Executable not found: $ExePath"
}

Write-Host "Launching $ExePath ..."
$proc = Start-Process -FilePath $ExePath -ArgumentList "--disable-gpu" -PassThru

Write-Host "Waiting $WaitSeconds seconds for startup..."
Start-Sleep -Seconds $WaitSeconds

$proc.Refresh()
if ($proc.HasExited) {
    Write-Error "Smoke test FAILED: process exited within ${WaitSeconds}s (exit code $($proc.ExitCode))"
}

# Electron spawns child processes; a healthy app has renderer + gpu children.
$children = Get-CimInstance Win32_Process -Filter "ParentProcessId = $($proc.Id)"
Write-Host "Process alive after ${WaitSeconds}s with $(@($children).Count) child process(es)."

Write-Host "Smoke test PASSED. Cleaning up..."
# Kill the whole tree (children first).
& taskkill /PID $proc.Id /T /F | Out-Null
exit 0
