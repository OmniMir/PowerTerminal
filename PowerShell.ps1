# PowerShell Profile Installation
#Copy-Item PowerShell.ps1 -Destination "${home}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Importing useful modules
Import-Module ($PSScriptRoot + "\Base64.psm1")
Import-Module ($PSScriptRoot + "\Docker.psm1")
Import-Module ($PSScriptRoot + "\Hash.psm1")
Import-Module ($PSScriptRoot + "\LittleApps.psm1")
Import-Module ($PSScriptRoot + "\RoboCopy.psm1")
Import-Module ($PSScriptRoot + "\SymLinks.psm1")
Import-Module ($PSScriptRoot + "\YouTubeDL.psm1")

# Simple updating of PowerShell Profile & Windows Terminal Settings
Copy-Item ($PSScriptRoot + "\PowerShell.ps1") -Destination ($PSScriptRoot + "\Microsoft.PowerShell_profile.ps1")
Copy-Item ($PSScriptRoot + "\Terminal.jsonc") -Destination "${home}\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# Fix for Bug witn Encoding in Interactive-CD
[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

# PowerShell Prompt with colors
$ESC = [char]27
Function Prompt {
	"$ESC[30;44m$env:USERNAME@$env:COMPUTERNAME$ESC[30;47m $(Get-Location) $ESC[30;42m$('PS' * ($nestedPromptLevel + 1))$ESC[0m "
}

Set-PSReadLineOption -Colors @{
	Command   = 'Blue'
	Comment   = 'DarkGray'
	Operator  = 'Yellow'
	Parameter = 'DarkRed'
	String    = 'White'
	Variable  = 'DarkGreen'
}

# Starting Directory
Set-Location /

# All Clear
Clear-Host
