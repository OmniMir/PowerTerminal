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
