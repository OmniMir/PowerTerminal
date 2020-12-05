# Dowload video from YouTube or other video-hostings with youtube-dl+ffmpeg
Function Extract-Subtitles-From-Video ($file, $format) {
	$ffFolder = "C:\Program Files\YouTube-DL\"
	$ffmpegExe = "ffmpeg"
	$ffprobeExe = "ffmpeg"
	$ffm = $ffFolder + $ffmpegExe
	$ffp = $ffFolder + $ffprobeExe

	$streams = $ffp -i $file -show_streams -loglevel error
	$streams = Select-String $streams -Pattern "codec_long", "index", "language"
	$streams = $streams -replace "TAG:"
	echo $streams
}

Set-Alias extract -Value Extract-Subtitles-From-Video
