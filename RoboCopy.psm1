#RoboCopy Syntax
#https://docs.microsoft.com/ru-ru/windows-server/administration/windows-commands/robocopy

##Copying All Folders and Files
Function Start-RoboCopy-All-Files($oldDirectory, $newDirectory) {
	if ($oldDirectory -and $newDirectory) {
		#Copy Parmeters
		#subdirectories with Empty directories
		#files with Data,Attributes,Timestamps
		#directories with Data,Attributes,Timestamps
		#create copies of Symbolic Links
		#only 100 Retries
		$options = "/E /COPY:DAT /DCOPY:DAT /SL /R:100"
		#Copy Process
		Invoke-Expression "robocopy '$oldDirectory' '$newDirectory' $options"
	}
 else {
		Write-Output "copyall path/to/old/dir path/to/new/dir"
	}
}
Set-Alias copyall -Value Start-RoboCopy-All-Files

##Create Tree of Files with Zero Length
Function Start-RoboCopy-Zero-Tree($oldDirectory, $newDirectory) {
	if ($oldDirectory -and $newDirectory) {
		robocopy `
			$oldDirectory `
			$newDirectory `
			/CREATE `
			/MIR `
			/COPY:DAT `
			/DCOPY:DAT `
			/R:100
	}
 else {
		Write-Output "copytree path/to/old/dir path/to/new/dir"
	}
}
Set-Alias copytree -Value Start-RoboCopy-Zero-Tree

##Very Simple Diff of File Trees
Function Compare-Difference-Of-Trees($oldDirectory, $newDirectory, $diff) {
	if ($oldDirectory -and $newDirectory -and $diff) {
		$treeold = tree $oldDirectory
		$treenew = tree $newDirectory
		Compare-Object $treeold $treenew > $diff
	}
 else {
		Write-Output "difftree path/to/dir1 path/to/dir2 path/to/difffile"
	}
}
Set-Alias difftree -Value Compare-Difference-Of-Trees
