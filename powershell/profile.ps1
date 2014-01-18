# profile.ps1 - main powershell profile script
# Applies to all hosts, so only put things here that are global

# Import the Pscx version that matches the current host
Import-Module Pscx -Version $Host.Version -ArgumentList "$(Split-Path $profile -parent)\Pscx.UserPreferences.ps1"

# Function for reloading your profile after edits w/out restarting the shell
# Simply dot source the function from, eg '. Reload-Profile'. These are stored
# in a separate member so additional scripts can add themselves to the list.
# Adapted from http://stackoverflow.com/a/5501909
$Profile | Add-Member NoteProperty Sources @(
    $Profile.AllUsersAllHosts,
    $Profile.AllUsersCurrentHost,
    $Profile.CurrentUserAllHosts,
    $Profile.CurrentUserCurrentHost
) -ErrorAction SilentlyContinue
function Reload-Profile {
    $Profile.Sources | % { if (Test-Path $_) { . $_ } }
}
Set-Alias reload Reload-Profile
function profile { Edit-File $Profile.CurrentUserAllHosts }

function Find-File([string[]]$inc) { Get-ChildItem -Recurse -Include $inc }
Set-Alias ff Find-File
Set-Alias dirs Find-File

function Find-FilePath([string[]]$inc) { Find-File $inc | Select-Object -ExpandProperty FullName }
Set-Alias ffp Find-FilePath
Set-Alias dirsb Find-FilePath

function Find-String([string]$pat, [string[]]$inc="*") { Find-File($inc) | Select-String -Pattern $pat }
Set-Alias f Find-String

function Get-Function($fn) { Get-Content Function:\$fn }
Set-Alias gf Get-Function

# By default use a single gvim instance per powershell instance. This overrides the
# Edit-File function provided by Pscx
$Env:gvimsvr = "GVIM:$pid"
function Edit-File {
    $svr = $Env:gvimsvr
    if (vim.exe --serverlist | Select-String $svr) {
        if ($args) {
            # Add the specified files to the existing instance
            gvim.exe --servername $svr --remote-silent $args
        } else {
            # No new files, give focus to existing instance
            vim.exe -c ":echo remote_foreground('$svr')" -c ":q"
        }
    } else {
        # Start a new instance
        gvim.exe --servername $svr $args
    }
}
Set-alias edit Edit-File
Set-alias v Edit-File

Set-Alias ibf Invoke-BatchFile

# Often need to check for admin privilege
function Test-Admin { Test-UserGroupMembership Administrators }

# To override some existing aliases with alias functions we have to remove them
function Remove-Alias($alias) { Remove-Item alias:$alias -Force -ErrorAction SilentlyContinue }

# Navigation aliases
Set-Alias p Pop-Location
function ~ { Push-Location (Get-PSProvider FileSystem).Home }
function .. { Set-Location .. }
function ... { ..;.. }
function .... { ...;.. }

function code { Push-Location ~\code\$args }
function dot { code dotfiles\$args }

# Typo aliases
Set-Alias dri dir
