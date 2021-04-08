# All filenames in current directory without extension
Function Basenames-OfFiles-InCurrentDirectory {
	(Get-ChildItem).BaseName
}
Set-Alias names -Value Basenames-OfFiles-InCurrentDirectory

# New directories by names from clipboard
Function NewDirectories-ByNames-InClipboard {
	$newDirs = Get-Clipboard -Format Text -TextFormatType Text
	Write-Output $newDirs
	New-Item -Path ($newDirs) -ItemType directory -Confirm
}
Set-Alias newdirs -Value NewDirectories-ByNames-InClipboard

# Find matching string in file
Function Find-NotUniqueStrings-InFile($file) {
	$results =
	Get-Content $file |
	Group -NoElement |
	Where { $_.Name -NotLike "" -and $_.Count -NotMatch 1 } |
	Format-Table -Property Name -AutoSize -HideTableHeaders

	if ($results) { Write-Output $results }
	else { Write-Output OK }
}
Set-Alias uniqs -Value Find-NotUniqueStrings-InFile

# Get full path of symbolic link
Function Get-Full-Path-of-Symbol-Link($path) {
	Get-Item $path | Select-Object -ExpandProperty Target
}
Set-Alias linkpath -Value Get-Full-Path-of-Symbol-Link

# Generate new GUID
Function Generate-New-GUID() {
	[guid]::NewGuid().ToString()
}
Set-Alias guid -Value Generate-New-GUID

# Windows grep Command
Function Find-As-GREP($target) {
	#Search string in all files at this location
	Get-ChildItem -Recurse | Select-String -Pattern $target -Context 1, 1 | ForEach-Object {
		#Get filename and number of line
		Write-Host $_.RelativePath($PWD) -ForegroundColor Black -BackgroundColor White -NoNewline
		Write-Host " " -NoNewline
		Write-Host $_.LineNumber
		#Get context and colors
		Write-Host $_.Context.PreContext -ForegroundColor Blue
		Write-Host ($_.Line -replace $target, "$([char]27)[32m$target$([char]27)[0m")
		Write-Host $_.Context.PostContext -ForegroundColor Blue
		#Set new line
		Write-Host
	}
}
Set-Alias grep -Value Find-As-GREP


# NeoFetch for Windows
Set-Alias version -Value "C:\Program Files\WinFetch\winfetch.exe"

# Android Debug Bridge and Fastboot
Set-Alias adb -Value "C:\Program Files\ADB\adb.exe"
Set-Alias fastboot -Value "C:\Program Files\ADB\fastboot.exe"
