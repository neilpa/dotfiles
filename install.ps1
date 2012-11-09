
Set-StrictMode -Version Latest

# Some commands (git) require being in the right directory
$dotfiles = Split-Path $MyInvocation.MyCommand.Path -Parent
Push-Location $dotfiles

Write-Host "Importing Powershell Community Extensions"
try {
    Import-Module Pscx -Version $Host.Version -ArgumentList $dotfiles\powershell\Pscx.UserPreferences.ps1
} catch [exception] {
    Import-Module $dotfiles\powershell\modules\pscx -ArgumentList $dotfiles\powershell\Pscx.UserPreferences.ps1
}

$admin = Test-UserGroupMembership Administrators
if (-not $admin) { Write-Warning "Not admin, symlinking and other operations may fail" }

Write-Host "Updating git submodules"
git submodule update --init --recursive


function Link-File($link, $target) {
    if (Test-Path $link) {
        Write-Host "Removing old symlink at $link"
        Get-ReparsePoint $link | Remove-ReparsePoint
    }
    if (Test-Path $link) {
        Write-Error "TODO - not linking $link"
        return
    }
    New-Symlink $link $target >$null
    if ((Get-ReparsePoint $link) -eq $null) {
        Write-Warning "Failed to link $link to $target"
    }
}

function Link-Directory($link, $target) {
    # TODO this should eventually handle merging with existing directories
    Link-File $link $target
}

Write-Host "Creating powershell symlinks"
New-Item ~\Documents\WindowsPowerShell\Modules -ItemType Directory -ErrorAction SilentlyContinue >$null
Link-File ~\Documents\WindowsPowerShell\profile.ps1 $dotfiles\powershell\profile.ps1
Link-File ~\Documents\WindowsPowerShell\Pscx.UserPreferences.ps1 $dotfiles\powershell\Pscx.UserPreferences.ps1
Get-ChildItem $dotfiles\powershell\modules | ? { $_.PSIsContainer } | % {
    Link-Directory ~\Documents\WindowsPowerShell\Modules\$($_.Name) $_
}

Write-Host "Creating vim symlinks"
Link-Directory ~\vimfiles $dotfiles\vim
Link-File ~\_vimrc $dotfiles\vim\vimrc
Link-File ~\_gvimrc $dotfiles\vim\gvimrc

Write-Host "Creating git symlinks"
Link-File ~\.gitconfig $dotfiles\git\gitconfig
Link-File ~\.gitignore $dotfiles\git\gitignore

# TODO Install the solarized colorscheme for the prompt

# TODO Get fix this
# Write-Host "Fixing powershell shortcuts"
# . ($dotfiles + "\powershell\Search-StartMenu.ps1")
# . ($dotfiles + "\powershell\Refresh-Shortcut.ps1")
# Search-StartMenu powershell | Refresh-Shortcut

Pop-Location

