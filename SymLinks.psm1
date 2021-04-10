##Create Symbolic Link
Function Write-SymLink($path, $target) {
	New-Item -ItemType SymbolicLink -Path $path -Target $target
}
Set-Alias symlink -Value Write-SymLink

##Get Full Path of Symbolic Link
Function Get-Full-Path-of-Symbol-Link($path) {
	Get-Item $path | Select-Object -ExpandProperty Target
}
Set-Alias linkpath -Value Get-Full-Path-of-Symbol-Link

##Convert Symbolic Links to .lnk-files
Function Convert-SymLinks-to-LNKs($recurse, $path) {
	#Change directory
	if ($path) {
		$path = "-Path $path"
	} else {
		$path = ""
	}
	#Recursive Mode On
	if ($recurse -eq "-r") {
		$recurse = "-Recurse"
	} else {
		$recurse = ""
	}
	#Finding all SymLinks in Directory and Subdirectories
	Get-ChildItem -Attributes ReparsePoint $path $recurse | ForEach-Object -Process {
		#Getting Path and Target
		$path = $_.FullName
		$target = [string]$_.Target #Convert to string IMPORTANT
		Write-Output $path + " ==>> " + $target
		#Creating sym\link\path.lnk with SymLink Target
		$shell = New-Object -ComObject WScript.Shell
		$link = $shell.CreateShortcut($path + ".lnk")
		$link.TargetPath = $target
		$link.Save()
		#Deleting symlink (Remove-Item is NOT working with symlinks)
		(Get-Item $path).Delete()
	}
}
