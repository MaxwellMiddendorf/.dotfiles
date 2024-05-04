# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load Angular CLI autocompletion.
source <(ng completion script)

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# PS1='$ '

# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

set horizontal-scroll-mode on

function sd() {

	if ([ -z $1 ])
	then
		cd "$(find * -type d | fzf)"
	else
		cd "$(find * -type d | fzf -q $1)"
	fi
}

function cd {
    builtin cd "$@" && ls -GF
}

export -f sd

function clear() {

	printf "\33c\e[3J"
}

export -f clear

set -o vi
set show-mode-in-prompt on
set vi-cmd-mode-string ":"
set vi-ins-mode-string "+"
alias cat='bat'
alias ls='ls -GF'
alias ..g='git rev-parse && cd "$(git rev-parse --show-cdup)"'

## Colors?  Used for the prompt.
#Regular text color
BLACK='\[\e[0;30m\]'
#Bold text color
BBLACK='\[\e[1;30m\]'
#background color
BGBLACK='\[\e[40m\]'
RED='\[\e[0;31m\]'
BRED='\[\e[1;31m\]'
BGRED='\[\e[41m\]'
GREEN='\[\e[0;32m\]'
BGREEN='\[\e[1;32m\]'
BGGREEN='\[\e[1;32m\]'
YELLOW='\[\e[0;33m\]'
BYELLOW='\[\e[1;33m\]'
BGYELLOW='\[\e[1;33m\]'
BLUE='\[\e[0;34m\]'
BBLUE='\[\e[1;34m\]'
BGBLUE='\[\e[1;34m\]'
MAGENTA='\[\e[0;35m\]'
BMAGENTA='\[\e[1;35m\]'
BGMAGENTA='\[\e[1;35m\]'
CYAN='\[\e[0;36m\]'
BCYAN='\[\e[1;36m\]'
BGCYAN='\[\e[1;36m\]'
WHITE='\[\e[0;37m\]'
BWHITE='\[\e[1;37m\]'
BGWHITE='\[\e[1;37m\]'

PROMPT_COMMAND=smile_prompt

function smile_prompt
{
if [ "$?" -eq "0" ]
then
#smiley
SC="${GREEN}:)"
else
#frowney
SC="${RED}:("
fi
if [ $UID -eq 0 ]
then
#root user color
UC="${RED}"
else
#normal user color
UC="${BWHITE}"
fi
#hostname color
HC="${BYELLOW}"
#regular color
RC="${BWHITE}"
#default color
DF='\[\e[0m\]'
PS1="[${UC}\u${RC}@${HC}\h ${RC}\W${DF}] ${SC}${DF} "
}
