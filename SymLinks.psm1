# Create Symbolic Link
Function Create-SymLink($path, $target) {
	New-Item -ItemType SymbolicLink -Path $path -Target $target
}
Set-Alias symlink -Value Create-SymLink

# Convert Symbolic Link to .lnk-files 
Function Convert-SymLinks-to-LNK($path, $recursive) {
	#Change directory
	Set-Location -Path $path
	#Recursive Mode On
	$recurse = ""
	if ($recursive -eq "Recursive") {
		$recurse = "-Recurse"
	}
	#Finding all SymLinks in Directory and Subdirectories
	Get-ChildItem $recurse -Attributes ReparsePoint | ForEach-Object -Process {
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
