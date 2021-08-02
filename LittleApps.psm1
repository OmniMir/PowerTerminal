##All Filenames in Current Directory without Extension
Function Get-Basenames-Of-Files-In-Current-Directory {
	#Get only name of file
	(Get-ChildItem).BaseName
}
Set-Alias names -Value Get-Basenames-Of-Files-In-Current-Directory

##New Directories by Names from Clipboard
Function Write-New-Directories-By-Names-In-Clipboard {
	#Get names from clipboard
	$newDirectories = Get-Clipboard
	Write-Output $newDirectories
	#Write new directories by that names
	New-Item -Path ($newDirectories) -ItemType directory -Confirm
}
Set-Alias newdirs -Value Write-New-Directories-By-Names-In-Clipboard

##Find Matching String in File
Function Find-NotUniqueStrings-InFile($file) {
	#Get identical strings in file
	$results =
	Get-Content $file |
	Group-Object -NoElement |
	Where-Object { $_.Name -NotLike "" -and $_.Count -NotMatch 1 } |
	Format-Table -Property Name -AutoSize -HideTableHeaders
	#View results of searching
	if ($results) {
		Write-Output $results
	}
	else {
		Write-Output OK
	}
}
Set-Alias uniqs -Value Find-NotUniqueStrings-InFile

##Generate New GUID
Function Get-New-Generated-GUID() {
	#Get new random GUID
	[guid]::NewGuid().ToString()
}
Set-Alias guid -Value Get-New-Generated-GUID

##Windows grep Command
Function Find-As-GREP($target) {
	#Search string in all files at this location
	Get-ChildItem -File -Recurse -Exclude *.exe, *.lnk, *.zip |
	Select-String -Pattern $target -Context 1, 1 |
	ForEach-Object {
		#Set new line
		Write-Host
		#Get filename and number of line
		Write-Host $_.RelativePath($PWD) -ForegroundColor Black -BackgroundColor White -NoNewline
		Write-Host " " -NoNewline
		Write-Host $_.LineNumber
		#Get context and colors
		$colorDefault = "$([char]27)[0m"
		$colorGreen = "$([char]27)[32m"
		Write-Host $_.Context.PreContext -ForegroundColor DarkGray
		Write-Host ($_.Line -replace $target, "$colorGreen$target$colorDefault")
		Write-Host $_.Context.PostContext -ForegroundColor DarkGray
	}
}
Set-Alias grep -Value Find-As-GREP

##Interactive-CD
Function Start-Interactive-Current-Directory($target) {
	#Set peco and its parameters as array
	$pecoExecution = 'C:\Program Files\Peco\peco.exe'
	$pecoArguments = @(
		'--initial-index=1'
		'--on-cancel=error'
		'--prompt=INTERACTIVE-CD ' + $PWD
		'--selection-prefix=>'
	)
	#Get all dirs in current location
	$directories = Get-ChildItem -Directory -Name
	if (!$directories) {
		$directories = "."
	}
	$directories = "..", $directories
	#Start with ' | & ' because Start-Process is NOT WORKING with pipelines
	Set-Location -Path ($directories | & $pecoExecution $pecoArguments)
}
Set-Alias cdi -Value Start-Interactive-Current-Directory

##No MarkDown Double New Lines
Set-Alias mded -Value "C:\Program Files\AutoGo\MarkDowned.exe"
##No MarkDown Double New Lines in All Files
Function MarkDownedAll($path) {
	$markDownedExecution = 'C:\Program Files\AutoGo\MarkDowned.exe'
	Get-ChildItem *.md | ForEach-Object {& $markDownedExecution $_.Name}
}

##NeoFetch for Windows
Set-Alias version -Value "C:\Program Files\WinFetch\winfetch.exe"

##Android Debug Bridge and Fastboot
Set-Alias adb -Value "C:\Program Files\ADB\adb.exe"
Set-Alias fastboot -Value "C:\Program Files\ADB\fastboot.exe"
