# All Hashes of File
Function Get-All-Hashes-Of-File($file, $hash = "NULL") {
	#Title
	$hashTitle = Get-Padded-Title "FILE:"
	Write-Host ($hashTitle + $file) -ForegroundColor Black -BackgroundColor White

	#Size
	$sizeTitle = Get-Padded-Title "SIZE:"
	$sizeValue = Get-Size-Of-File $file
	Write-Host ($sizeTitle + $sizeValue) -ForegroundColor Black -BackgroundColor White

	#Hashes
	Get-Hash-Of-File $file "SHA256" $hash
	Get-Hash-Of-File $file "SHA384" $hash
	Get-Hash-Of-File $file "SHA512" $hash
	Get-Hash-Of-File $file "SHA1" $hash
	Get-Hash-Of-File $file "MD5" $hash
}
Set-Alias hash -Value Get-All-Hashes-Of-File

# Hash of File by picked Algorithm
Function Get-Hash-Of-File($file, $algorithm, $hash) {
	#Title
	$hashTitle = Get-Padded-Title ($algorithm)
	#Calculating hash
	$filehash = (Get-FileHash -Path ($file) -Algorithm ($algorithm)).Hash
	#Only Result
	if ($hash -eq "NULL") {
		Write-Host ($hashTitle + $filehash)
	}
	#Comparison with Hash and Result
	elseif ($hash -ne $filehash) {
		Write-Host ($hashTitle + $filehash) -BackgroundColor DarkRed
	}
	elseif ($hash -eq $filehash) {

		Write-Host ($hashTitle + $filehash) -BackgroundColor DarkGreen
	}
}

# Size of File
Function Get-Size-Of-File($file) {
	#Get Size of File
	$filesize = (Get-ChildItem $file).Length

	#Rounding to KB-MB-GB
	$size = ""
	if ($filesize -ge 1GB) {
		$bytesize = "GB"
	}
	elseif ($filesize -ge 1MB) {
		$bytesize = "MB"
	}
	elseif ($filesize -ge 1KB) {
		$bytesize = "KB"
	}
	$size = Get-FileSize-Rounding $filesize $bytesize
	if ($bytesize) {
		$size = " = " + $size
	}

	#Get Size of File in Bytes (and KB-MB-GB)
	return ("" + $filesize + "B" + $size)
}
Function Get-FileSize-Rounding($filesize, $bytesize) {
	#Set KB-MB-GB
	switch ($bytesize) {
		"KB" { $byte = 1KB }
		"MB" { $byte = 1MB }
		"GB" { $byte = 1GB }
		default { return "" }
	}
	#Rounding to KB-MB-GB
	$size = $filesize / $byte
	$size = [string]$size
	$size = $size -replace ",", "." #Hack to [math]
	$size = [math]::Round($size , 2)
	return ("" + $size + $bytesize)
}

# Padded Title
Function Get-Padded-Title($title) {
	$titleWidth = 8
	$Pad = " "
	return $title.PadRight($titleWidth, $Pad)
}
