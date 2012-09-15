
Set-StrictMode -Version Latest

# Some commands (git) require being in the right directory
$dotfiles = Split-Path $MyInvocation.MyCommand.Path -Parent
Push-Location $dotfiles

Write-Host "Importing Powershell Community Extensions"
Import-Module $dotfiles\powershell\modules\pscx -ArgumentList $dotfiles\powershell\Pscx.UserPreferences.ps1

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
}

function Link-Directory($link, $target) {
    # TODO this should eventually handle merging with existing directories
    Link-File $link $target
}

Write-Host "Creating powershell symlinks"
Link-Directory ~\Documents\WindowsPowerShell $dotfiles\powershell

Write-Host "Creating vim symlinks"
Link-Directory ~\vimfiles $dotfiles\vim
Link-File ~\_vimrc $dotfiles\vim\vimrc
Link-File ~\_gvimrc $dotfiles\vim\gvimrc

Write-Host "Creating git symlinks"
Link-File ~\.gitconfig $dotfiles\git\gitconfig
Link-File ~\.gitignore $dotfiles\git\gitignore

Pop-Location

