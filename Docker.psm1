# Constants
$Administration = "start", "update", "containers", "images", "rm-containers", "rm-images"
$LocalRepository = "D:\Project8\PowerTerminal\"
$Systems = "cpp", "git", "go", "node", "php", "python"
$Repository = "omnimir/"
$Tag = ":latest"

# Docker Control
Function Docker-Simple-Control($command) {
	$host.UI.RawUI.WindowTitle = "$command | ${pwd}"
	Switch ($command) {
		start {
			#docker pull alpine/nikto
			#docker pull bash
			#docker pull browsh/browsh
			#docker pull cirrusci/flutter
			#docker pull chocobozzz/peertube
			#docker pull dexec/lua
			#docker pull elasticsearch
			#docker pull gitea/gitea
			#docker pull google/dart
			#docker pull securecodebox/nmap
			#docker pull ipfs/go-ipfs
			#docker pull kylemanna/openvpn
			#docker pull libreoffice/online
			#docker pull llvm
			#docker pull mariadb
			#docker pull mathematica12/mathematica12
			#docker pull microsoft/playwright
			#docker pull mcr.microsoft.com/powershell
			#docker pull n8nio/n8n
			#docker pull nextcloud
			#docker pull nginx
			#docker pull nickblah/lua
			#docker pull pandoc/core
			#docker pull postgres
			docker pull omnimir/git
			docker pull omnimir/go
			#docker pull omnimir/haskell
			docker pull omnimir/node
			docker pull omnimir/php
			docker pull omnimir/python
			#docker pull romancin/ptokax (dc++)
			#docker pull tensorflow/tensorflow
			#docker pull wordpress
			#docker pull yacy/yacy_search_server
		}
		update {
			docker images --format "{{.Repository}}:{{.Tag}}" | ForEach-Object { docker pull "$_" }
		}
		containers {
			docker ps
		}
		rm-containers {
			docker rm $(docker ps -a -q)
		}
		images {
			docker images
		}
		rm-images {
			docker rmi $(docker images -q)
		}
		cpp {
			docker run -it --rm `
				--name cpp `
				-v ${pwd}:/project `
				-w /project `
				omnimir/cpp:latest `
				/bin/bash
		}
		git {
			docker run -it --rm `
				--name git `
				-v ${home}/_GITPATH:/root `
				-v ${pwd}:/project `
				-w /project `
				omnimir/git:latest `
				/bin/bash
		}
		go {
			docker run -it --rm `
				--name go `
				-e GOARCH=amd64 `
				-e GOOS=windows `
				-e GOPATH=/gopath `
				-v ${home}/_GOPATH:/gopath `
				-v ${pwd}:/project `
				-w /project `
				omnimir/go:latest `
				/bin/bash
		}
		node {
			docker run -it --rm `
				--name node `
				-p 8080:8080 `
				-v ${home}/_NODEPATH:/usr/local/lib/node_modules `
				-v ${pwd}:/project `
				-w /project `
				omnimir/node:latest `
				/bin/bash
		}
		php {
			docker run -it --rm `
				--name php `
				-p 8080:8080 `
				-v ${pwd}:/project `
				-w /project `
				omnimir/php:latest `
				/bin/bash
		}
		python {
			docker run -it --rm `
				--name python `
				-v ${home}/_PYPATH:/usr/local/lib/python3.8/site-packages `
				-v ${pwd}:/project `
				-w /project `
				omnimir/python:latest `
				/bin/bash
		}
		default {
			Write-Host "Administration" -BackgroundColor White -ForegroundColor Black
			Write-Output $Administration
			Write-Host "Systems" -BackgroundColor White -ForegroundColor Black
			Write-Output $Systems
		}
	}
	$host.UI.RawUI.WindowTitle = "PowerShell"
}
Set-Alias dock -Value Docker-Simple-Control

# Docker Build Image
Function Docker-Simple-Build($file, $name) {
	if ($file -and $name) {
		docker build -f $file -t $name .
		docker push $name
	}
	else {
		Write-Output 'dockbuild path/to/Dockerfile "repository/name:tag"'
	}
}
Set-Alias dockbuild -Value Docker-Simple-Build

# Docker Build All Images
Function Docker-All-Build() {
	$Systems | ForEach-Object {
		$dockerFile = $LocalRepository + $_ + ".Dockerfile"
		$imageName = $Repository + $_ + $Tag
		Docker-Simple-Build $dockerFile $imageName
	}
}
Set-Alias dockbuildall -Value Docker-All-Build

# Arguments AutoCompletion for dock
Register-ArgumentCompleter -CommandName Docker-Simple-Control -ParameterName command -ScriptBlock {
	param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

	$Arguments = $Administration + $Systems
	$Arguments | Where-Object {
		$_ -like "$wordToComplete*"
	} | ForEach-Object {
		"$_"
	}
}
# Arguments AutoCompletion for dockbuild
Register-ArgumentCompleter -CommandName Docker-Simple-Build -ParameterName name -ScriptBlock {
	param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

	$Arguments = $Systems | ForEach-Object { $Repository + $_ + $Tag }
	$Arguments | Where-Object {
		$_ -like "$wordToComplete*"
	} | ForEach-Object {
		"$_"
	}
}
