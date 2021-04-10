# Base64 Encoding
Function Convert-String-To-Base64($text) {
	$bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
	$encodedText = [System.Convert]::ToBase64String($bytes)
	Write-Output $encodedText
}
Set-Alias b64enc -Value Convert-String-To-Base64

# Base64 Decoding
Function Convert-From-Base64($encodedText) {
	$bytes = [System.Convert]::FromBase64String($encodedText)
	$text = [System.Text.Encoding]::UTF8.GetString($bytes)
	Write-Output $text
}
Set-Alias b64dec -Value Convert-From-Base64
