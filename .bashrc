##UBUNTU BASH SETTINGS
case $- in
*i*) ;;
*) return ;;
esac
#History
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize
##Environment
color_prompt=yes
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi
#Completion
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

##UNIVERSAL ALIASES (Required caca-utils, cloc, endlessh, inxi, neofetch)
alias aptsearch='apt search --names-only' #apt search only by name
alias byebye='sudo shutdown -r now'       #restart
alias countnow='cloc --hide-rate --sum-one .'
alias edit='nano -NSmu$'
alias dirspace='du -h --max-depth=1'
alias diskspace='df -h --exclude-type=tmpfs --exclude-type=devtmpfs'
alias grep='grep --color --ignore-case --line-number'
alias goodbye='sudo shutdown -h now'                                                    #shutdown
alias hardware='inxi -Fo'                                                               #view hardware information
alias historybest='history | awk '{print $2}' | sort | uniq -c | sort -rn | head -n 25' #show 25 most use bash commands
alias historydel='history -r'                                                           #delete bash commands from current session
alias image='cacaview'                                                                  #image in terminal
alias ls='ls --color --group-directories-first -p -1'                                   #show files&dirs in current directory
alias lsa='ls -A'                                                                       #show all files&dirs in current directory
alias lsl='lsa -lh --time-style=iso'                                                    #show all files&dirs in current directory with long format
alias mkdir='mkdir -p'
alias rm='rm -iv'
alias rmdir='rm -iRv'
alias sshtarpit='sudo nohup endlessh -p 22'
alias sudo='sudo '
alias view='nano -Svm$'
alias version='neofetch'
export EDITOR='nano -NSmu$'
export VISUAL='nano -Svm$'
export TERM='xterm-256color'

##LITTLE APPLICATIONS
#Simple Interactive CD (required peco)
cdi() {
	cd "$(
		(echo ".." && (ls --color=never -p -A | \grep '/')) |
			(peco --initial-index=1 --on-cancel=error --prompt="INTERACTIVE-CD: $PWD" --selection-prefix=">" || echo ".")
	)" ||
		return
}

#Simple Interactive PushD (required peco)
alias pd='pushd . 1>/dev/null'
pdi() {
	cd "$(
		(dirs -p | tail -n +2) |
			(peco --initial-index=1 --on-cancel=error --prompt="INTERACTIVE-PD: $PWD" --selection-prefix=">" || echo ".") |
			(
				read -r result
				echo "${result/\~/$HOME}"
			)
	)" ||
		return
}

#Get Certificate and Fingerprint of Site
sitecert() {
	echo "q" |
		openssl s_client -connect "$1":443 |
		openssl x509 -startdate -enddate -fingerprint
}

#Everything will UPdate, UPgrade and remove AWAY + SNAP if snap is here
upupaway_function() {
	(
		echo -e "\033[7mapt update\033[0m"
		apt update
	) &&
		(
			echo -e "\033[7mapt upgrade\033[0m"
			apt upgrade --yes
		) &&
		(
			echo -e "\033[7mapt autoremove\033[0m"
			apt autoremove --yes
		) &&
		if (dpkg -l | grep "ii  snapd") >/dev/null; then
			(
				echo -e "\033[7msnap refresh\033[0m"
				snap refresh &&
					snap set system refresh.hold="$(date --date="today+30 days" --iso-8601=seconds)"
			)
		fi
}
alias upupaway='sudo bash -c "$(declare -f upupaway_function); upupaway_function"'

#Update dot-files from github or other places
updots() {
	HOSTSERVER="https://raw.githubusercontent.com/OmniMir/PowerTerminal/dev"
	wget "$HOSTSERVER/.bashrc" -O "$HOME"/.bashrc -q && echo ".bashrc updated"
	wget "$HOSTSERVER/.nanorc" -O "$HOME"/.nanorc -q && echo ".nanorc updated"
}
#Install Required Software
alias updots_required='sudo apt install caca-utils cloc endlessh inxi neofetch peco'

#Weather in Terminal for You (Moscow, Russia)
alias weather='curl ru.wttr.in/Moscow?0QT'

##PS1 PROMPT
#Terminal Title & Chroot
PStitle="\[\e]0;\h\a\]"
PSchroot="${debian_chroot:+($debian_chroot)}"
#Desktop Style "kapsilon@K0 /home $" with colors
PSuser="\[\033[34;07m\]\u@\h\[\033[00m\]"
PSpath="\[\033[37;07m\] \w \[\033[00m\]"
PSsymbol="\[\033[32;07m\]\$\[\033[00m\] "
PSdesktop="$PStitle$PSchroot$PSuser$PSpath$PSsymbol"
#Laptop Style "kapsilon@K0 /home 90% $" with colors and Battery status
PSbattery="\[\033[31;07m\][$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)%]\[\033[00m\]"
PSlaptop="$PStitle$PSchroot$PSuser$PSbattery$PSpath$PSsymbol"
#Minimal Style "kapsilon@K0 /home 90% $" with colors for Android Termux
PSminimal="$PSpath$PSsymbol"

if [[ "$HOSTNAME" == "K0" ]]; then
	export PS1=$PSdesktop
elif [[ "$HOSTNAME" == "K1" ]]; then
	export PS1=$PSdesktop
elif [[ "$HOSTNAME" == "K2" ]]; then
	export PS1=$PSdesktop
	#Mount All Disks
	alias mountall='sudo mount /Документы/; sudo mount /Загрузки/; sudo mount /Игры/; sudo mount /Разное/'
elif [[ "$HOSTNAME" == "Knb" ]]; then
	export PS1=$PSlaptop
elif [[ "$HOSTNAME" == "Kpi" ]]; then
	export PS1=$PSdesktop
elif [[ "$HOSTNAME" == "localhost" ]]; then
	#For Android Termux
	export PS1=$PSminimal
	#Always SUDO without SUDO
	alias sudo=' '
else
	export PS1='\u@\h  \w $ '
fi
