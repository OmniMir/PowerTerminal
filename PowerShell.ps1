# PowerShell Profile Installation
#Copy-Item PowerShell.ps1 -Destination "${home}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

# Importing useful modules
Import-Module ($PSScriptRoot + "\Docker.psm1")
Import-Module ($PSScriptRoot + "\LittleApps.psm1")
Import-Module ($PSScriptRoot + "\RoboCopy.psm1")
Import-Module ($PSScriptRoot + "\YouTubeDL.psm1")

# Simple updating of PowerShell Profile & Windows Terminal Settings
Copy-Item ($PSScriptRoot + "\PowerShell.ps1") -Destination ($PSScriptRoot + "\Microsoft.PowerShell_profile.ps1")
Copy-Item ($PSScriptRoot + "\Terminal.json") -Destination "${home}\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# Fix for Bug with Big letters 
Remove-Module -Name PSReadline

# PowerShell Prompt with colors
$ESC = [char]27
Function Prompt {
	"$ESC[30;104m$env:USERNAME@$env:COMPUTERNAME$ESC[30;47m $(Get-Location) $ESC[30;102m$('PS' * ($nestedPromptLevel + 1))$ESC[0m "
}

Set-PSReadLineOption -Colors @{
	Command   = 'DarkBlue'
	Operator  = 'DarkYellow'
	Parameter = 'DarkYellow'
	String    = 'White'
}

# All Clear
Clear-Host
Set-Location /
