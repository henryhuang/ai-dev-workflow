$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$CopilotHome = if ($env:COPILOT_HOME) { $env:COPILOT_HOME } else { Join-Path $HOME ".copilot" }
$AgentsDst = Join-Path $CopilotHome "agents"
$InstructionsDst = Join-Path $CopilotHome "instructions"
$BackupRoot = Join-Path $CopilotHome "backups\ai-dev-workflow"
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

$AgentsSrc = Join-Path $ScriptDir ".github\agents"
$InstructionsSrc = Join-Path $ScriptDir ".github\copilot-instructions.md"

if (-not (Test-Path $AgentsSrc -PathType Container)) {
    throw "Agent source directory not found: $AgentsSrc"
}

if (-not (Test-Path $InstructionsSrc -PathType Leaf)) {
    throw "Instructions source file not found: $InstructionsSrc"
}

New-Item -ItemType Directory -Force -Path $AgentsDst | Out-Null
New-Item -ItemType Directory -Force -Path $InstructionsDst | Out-Null

function Backup-IfExists {
    param([string]$Target)

    if (Test-Path $Target -PathType Leaf) {
        $Relative = $Target.Substring($CopilotHome.Length).TrimStart("\", "/")
        $Backup = Join-Path (Join-Path $BackupRoot $Timestamp) $Relative
        $BackupDir = Split-Path -Parent $Backup
        New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
        Copy-Item -Force $Target $Backup
        Write-Host "  backup: $Target -> $Backup"
    }
}

Write-Host "Installing AI Dev Workflow"
Write-Host "Copilot home: $CopilotHome"
Write-Host ""
Write-Host "Agents:"

Get-ChildItem -Path $AgentsSrc -Filter "*.md" | ForEach-Object {
    $Base = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    $Dst = Join-Path $AgentsDst "$Base.agent.md"
    Backup-IfExists $Dst
    Copy-Item -Force $_.FullName $Dst
    Write-Host "  installed: $Dst"
}

$InstructionTarget = Join-Path $InstructionsDst "ai-dev-workflow.instructions.md"
Backup-IfExists $InstructionTarget

$Header = @'
---
name: AI Dev Workflow
description: Personal AI-assisted development rules
applyTo: "**"
---

'@

$Body = Get-Content -Raw -Path $InstructionsSrc
Set-Content -Path $InstructionTarget -Value ($Header + $Body) -Encoding UTF8

Write-Host ""
Write-Host "Instructions:"
Write-Host "  installed: $InstructionTarget"
Write-Host ""
Write-Host "Done."
Write-Host "Restart VS Code or reload the window if the agents are not immediately visible."
Write-Host "Use /agents in Copilot Chat to verify the custom agents."
