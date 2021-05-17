##Dowload Video from YouTube or Other Video-Hostings with youtube-dl+ffmpeg
Function Start-Dowload-Video-From-YouTube ($link, $format, $user, $password) {
	#Set YouTube-DL
	$ytdlFolder = "C:\Program Files\YouTube-DL\"
	$ytdlExe = "youtube-dl.exe"
	$ytdl = $ytdlFolder + $ytdlExe
	#Set download directory
	$downloadFolder = $HOME + "\Desktop\Download\"
	$downloadFile = "%(title)s__%(resolution)s.%(ext)s"
	$dl = $downloadFolder + $downloadFile
	#Set authentication
	$authentication = ""
	if ($user) {
		$authentication = "--username " + $user + " --password " + $password + " "
	}

	#Set YouTube-DL Title
	$host.UI.RawUI.WindowTitle = "YouTube-DL"

	#Script in Work
	if ($link -and $format) {
		#Download 1080p Video from YouTube
		if ($format -eq "1080") {
			$format = "-f 137+22"
		}
		#Download Only Subtitles to srt
		elseif ($format -eq "subs") {
			$format = "--write-sub --convert-subs srt --sub-lang en,ru --skip-download "
			#Fix for not converting to srt "ffmpeg.exe -i subtitle.vtt subtitles.srt"
		}
		#Download Only YouTube-Automated Subtitles to srt
		elseif ($format -eq "asubs") {
			$format = "--write-auto-sub --convert-subs srt --sub-lang en,ru --skip-download"
			#Fix for not converting to srt "ffmpeg.exe -i subtitle.vtt subtitles.srt"
		}
		#Download Only Music to mp3
		elseif ($format -eq "mp3") {
			$format = "--extract-audio --audio-format mp3 --audio-quality 0"
		}
		#Not Download Only Show formats as null format (For example use with password)
		elseif ($format -eq "formats") {
			$arguments = "-F " + $authentication + $link
			Start-Process -FilePath $ytdl -ArgumentList $arguments -NoNewWindow -Wait
			Return
		}
		#Download Video in Custom Format
		else {
			$format = "-f " + $format
		}
		#Download Process
		$arguments = $format + " -o " + $dl + " " + $authentication + $link
		Start-Process -FilePath $ytdl -ArgumentList $arguments -NoNewWindow -Wait
	}
	#Only Show formats
	elseif ($link) {
		$arguments = "-F " + $authentication + $link
		Start-Process -FilePath $ytdl -ArgumentList $arguments -NoNewWindow -Wait
	}

	#Show Help without arguments
	else {
		Write-Output "For view all variants: 'yt https://yourlink.to/video'"
		Write-Output "`r"
		Write-Output "For download variant (video+audio): 'yt https://yourlink.to/video 137+22'"
		Write-Output "For download 1080p+bestaudio: 'yt https://yourlink.to/video 1080'"
		Write-Output "For download subtitles: 'yt https://yourlink.to/video subs'"
		Write-Output "For download automated subtitles: 'yt https://yourlink.to/video asubs'"
		Write-Output "For download only music: 'yt https://yourlink.to/video mp3'"
		Write-Output "`r"
		Write-Output "For view all variants with Authentication: 'yt https://yourlink.to/video formats login password'"
		Write-Output "For download variant (video+audio) with Authentication: 'yt https://yourlink.to/video 137+22 login password'"
	}

	#Set Default Title
	$host.UI.RawUI.WindowTitle = "PowerShell"
}
Set-Alias yt -Value Start-Dowload-Video-From-YouTube
