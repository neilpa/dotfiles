# Command Prompt - Consolas 15pt font
Set-ItemProperty HKCU:\Console FaceName Consolas
Set-ItemProperty HKCU:\Console FontSize 0xF0000
Set-ItemProperty HKCU:\Console QuickEdit 1

# Explorer defaults
$advanced = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty $advanced HideFileExt 0
Set-ItemProperty $advanced Hidden 1
Set-ItemProperty $advanced ShowSuperHidden 1

