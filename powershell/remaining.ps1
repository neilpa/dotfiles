# Load in support modules
# Import-Module Pscx -Arg @{CD_EchoNewLocation = $false} -Version $Host.Version

# Load the AppxDebug module if it exists
Import-Module "$Env:ProgramFiles\Microsoft Visual Studio 11.0\Common7\IDE\Remote Debugger\Appx\AppxDebug.dll" -ErrorAction SilentlyContinue

# Pipe a list of MatchInfo objects (from Select-String) to the Vim location list. The
# nice thing about this approach is that the location list is updated asynchronously 
# without forcing repaints/jumping in Vim.
function Write-VimLocationList {
    begin {
        # Clear any existing location list - uses vim instead of gvim to avoid popping a dialog
        vim.exe --servername $Env:gvimsvr --remote-expr "setloclist(0, [], 'r')" >$null
    }
    process {
        $expr = "setloclist(0, [{'bufnr':bufnr('" + $_.Path + "', 1), 'lnum':" + $_.LineNumber + "}], 'a')"
        vim.exe --servername $Env:gvimsvr --remote-expr $expr >$null
    }
}

