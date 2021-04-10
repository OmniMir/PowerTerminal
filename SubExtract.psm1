##Extract Subtitles from Video File
Function Export-Subtitles-From-Video ($file, $format) {
	$ffFolder = "C:\Program Files\YouTube-DL\"
	$ffmpegExe = "ffmpeg"
	$ffprobeExe = "ffmpeg"
	$ffm = $ffFolder + $ffmpegExe
	$ffp = $ffFolder + $ffprobeExe

	$streams = "$ffp -i $file -show_streams -loglevel error"
	$streams = Select-String $streams -Pattern "codec_long", "index", "language"
	$streams = $streams -replace "TAG:"
	Write-Output $streams
}
Set-Alias extract -Value Export-Subtitles-From-Video

