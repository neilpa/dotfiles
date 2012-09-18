function Refresh-Shortcut {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, valueFromPipeline = $true)]
        $lnk
    )

    begin {
        $shell = New-Object -COM WScript.Shell
    }

    process {
        $input
        $old = $shell.CreateShortcut($lnk.FullName);

        $props = @{
            FullName=$lnk.FullName
            Arguments=$old.Arguments
            Description=$old.Description
            IconLocation=$old.IconLocation
            TargetPath=$old.TargetPath
            WorkingDirectory=$old.WorkingDirectory
        }
        $lnk.Delete() >$null

        $new = $shell.CreateShortcut($props.FullName)
        $new.Arguments = $props.Arguments
        $new.Description = $props.Description
        $new.IconLocation = $props.IconLocation
        $new.TargetPath = $props.TargetPath
        $new.WorkingDirectory = $props.WorkingDirectory
        $new.Save()
    }
}
