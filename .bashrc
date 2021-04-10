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
alias goodbye='sudo shutdown -h now' #shutdown
alias hardware='inxi -Fo'
alias image='cacaview' #image in terminal
alias ls='ls --color --group-directories-first -p'
alias lsa='ls --color --group-directories-first -p -A'
alias lsl='ls --color --group-directories-first -p -A -lh --time-style=iso'
alias mkdir='mkdir -p'
alias pd='pushd . 1>/dev/null' #use with "pdi"
alias rm='rm -iv'
alias rmdir='rm -iRv'
alias sshtarpit='sudo nohup endlessh -p 22'
alias sudo='sudo '
alias view='nano -Svm$'
alias version='neofetch'
export EDITOR='nano -NSmu$'
export VISUAL='nano -Svm$'
export TERM='xterm-256color'

##LITTLE APPLICATIONS (Required peco)
#Simple Interactive CD (required peco)
alias cdi='cd `
		  (echo ".." && ls -A --color=never --group-directories-first -p) |
		  (peco --initial-index=1 --on-cancel=error --prompt="INTERACTIVE-CD: $PWD" --selection-prefix=">" || echo ".")
		  `'

#Simple Interactive PushD, use with "pd" (required peco)
alias pdi='cd `
		  (dirs -p | tail -n +2) |
		  (peco --initial-index=1 --on-cancel=error --prompt="INTERACTIVE-PD: $PWD" --selection-prefix=">" || echo ".") |
		  (read result; echo "${result/\~/$HOME}")
		  `'

#Everything will UPdate, UPgrade and remove AWAY + SNAP if snap is here
alias upupaway='echo -e "\033[7mapt update\033[0m"; sudo apt update &&
				echo -e "\033[7mapt upgrade\033[0m"; sudo apt upgrade --yes &&
				echo -e "\033[7mapt autoremove\033[0m"; sudo apt autoremove --yes &&
				if (dpkg -l | grep "ii  snapd") > /dev/null; then
				(echo -e "\033[7msnap refresh\033[0m"; sudo snap refresh &&
					sudo snap set system refresh.hold=$(date --date="today+30 days" --iso-8601=seconds);)
				fi
				'

#Update dot-files from github or other places
DOTFILESHOSTSERVER="https://raw.githubusercontent.com/OmniMir/PowerTerminal/dev"
alias updots='wget "$DOTFILESHOSTSERVER/.bashrc" -O $HOME/.bashrc -q && echo ".bashrc updated";
			  wget "$DOTFILESHOSTSERVER/.nanorc" -O $HOME/.nanorc -q && echo ".nanorc updated"
			  '
#Install Required Software
alias updots_required='sudo apt install caca-utils cloc endlessh inxi neofetch peco'

#Weather in terminal for you (Moscow, Russia)
alias weather='curl ru.wttr.in/Moscow?0QT'

##PS1 PROMPT
#Desktop Style "kapsilon@K0 /home $" with colors
PSdesktop='\[\e]0;\h\a\]${debian_chroot:+($debian_chroot)}\[\033[01;07;34m\]\u@\h\[\033[00m\]\[\033[07;37m\] \w \[\033[00m\]\[\033[01;07;32m\]\$\[\033[00m\] '
#Laptop Style "kapsilon@K0 /home 90% $" with colors and Battery status
PSlaptop='\[\e]0;\h\a\]${debian_chroot:+($debian_chroot)}\[\033[01;07;34m\]\u@\h\[\033[00m\]\[\033[07;37m\] \w \[\033[00m\]\[\033[01;07;32m\]\$\[\033[00m\]\[\033[07;31m\][$(cat /sys/class/power_supply/BAT0/capacity)%]\[\033[00m\] '
#Minimal Style "kapsilon@K0 /home 90% $" with colors for Android Termux
PSminimal='\[\033[07;37m\] \w \[\033[00m\]\[\033[01;07;92m\]\$\[\033[00m\] '

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
else export PS1= '\u@\h  \w $ '
fi

#----------------------------------------------------
#PS1 for Ubuntu on Windows (other colors)
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;07;94m\]\u@\h\[\033[00m\]\[\033[07;37m\] \w \[\033[00m\]\[\033[01;07;92m\]\$\[\033[00m\] '
