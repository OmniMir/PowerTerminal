# All Hashes of File
Function Get-All-Hashes-Of-File($file, $hash = "NULL") {
	#Title
	$hashTitle = Get-Padded-Title "FILE:"
	Write-Host ($hashTitle + $file) -ForegroundColor Black -BackgroundColor White

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
		Write-Host ($hashTitle + $filehash) -BackgroundColor Red
	}
	elseif ($hash -eq $filehash) {
	
		Write-Host ($hashTitle + $filehash) -BackgroundColor Green
	}
}

# Padded Title
Function Get-Padded-Title($title) {
	$titleWidth = 8
	$Pad = " "
	return $title.PadRight($titleWidth, $Pad)
}
