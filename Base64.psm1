# Base64 Encoding
Function Encode-String-To-Base64($text) {
	$bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
	$encodedText = [System.Convert]::ToBase64String($bytes)
	Write-Output $encodedText
}
Set-Alias b64encode -Value Encode-String-To-Base64

# Base64 Decoding
Function Decode-String-From-Base64($encodedText) {
	$bytes = [System.Convert]::FromBase64String($encodedText)
	$text = [System.Text.Encoding]::UTF8.GetString($bytes)
	Write-Output $text
}
Set-Alias b64decode -Value Decode-String-From-Base64
