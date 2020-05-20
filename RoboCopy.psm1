# RoboCopy Syntax
# https://docs.microsoft.com/ru-ru/windows-server/administration/windows-commands/robocopy

# Copying all folders and files
Function RoboCopy-All-Files($oldDirectory, $newDirectory) {
	if ($oldDirectory -and $newDirectory) {
		robocopy  `
			$oldDirectory `
			$newDirectory `
			/E `
			/COPY:DAT `
			/DCOPY:DAT `
			/R:100 `
			/sl
	}
 else {
		Write-Output "difftree path/to/old/dir path/to/new/dir"
	}
}
Set-Alias copyall -Value RoboCopy-All-Files

# Create tree of files with zero length
Function RoboCopy-Zero-Tree($oldDirectory, $newDirectory) {
	if ($oldDirectory -and $newDirectory) {
		robocopy  `
			$oldDirectory `
			$newDirectory `
			/CREATE `
			/MIR `
			/COPY:DAT `
			/DCOPY:DAT `
			/R:100
	}
 else {
		Write-Output "difftree path/to/old/dir path/to/new/dir"
	}
}
Set-Alias copytree -Value RoboCopy-Zero-Tree

# Very simple diff of file trees
Function Compare-Difference-Of-Trees($oldDirectory, $newDirectory, $diff) {
	if ($oldDirectory -and $new -and $diff) {
		$treeold = tree $oldDirectory
		$treenew = tree $newDirectory
		Compare-Object $treeold $treenew > $diff
	}
 else {
		Write-Output "difftree path/to/dir1 path/to/dir2 path/to/difffile"
	}
}
Set-Alias difftree -Value Compare-Difference-Of-Trees