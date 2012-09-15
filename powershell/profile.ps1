# profile.ps1 - main powershell profile script
# Applies to all hosts, so only put things here that are global

# To override some existing aliases with alias functions we have to remove them
function Remove-Alias($alias) { Remove-Item alias:$alias -Force -ErrorAction SilentlyContinue }

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

# Vim Helpers

# By default use a single gvim instance per powershell instance
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

# Function to invoke a batch script that inherits any environment changes it made
# http://www.leeholmes.com/blog/2006/05/11/nothing-solves-everything-%E2%80%93-powershell-and-other-technologies
function Invoke-BatchFile {
    param([string]$script, [string]$params)
    $temp = [IO.Path]::GetTempFileName()

    # Store the output of cmd.exe and the environment table after the batch file completes
    cmd.exe /c " `"$script`" $params && set > `"$temp`" "

    # For each environment variable in the temp  file, add it to our local environment
    Get-Content $temp | Foreach-Object {
        if ($_ -match "^(.*?)=(.*)$") {
            Set-Content "Env:\$($matches[1])" $matches[2]
        }
    }

    Remove-Item $temp
}
Set-Alias ibf Invoke-BatchFile

# Often need to check for admin privilege
function Test-Admin {
    $user = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $user.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Navigation aliases
Set-Alias p Pop-Location
function ~ { Push-Location ~ }
function .. { Set-Location .. }
function ... { ..;.. }
function .... { ...;.. }

