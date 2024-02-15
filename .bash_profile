# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"



# Load Angular CLI autocompletion.
source <(ng completion script)

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

export OPENAI_API_TOKEN="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"

set horizontal-scroll-mode on

function run() {
	open -a $1
}

export -f run

function sd() {

	if ([ -z $1 ])
	then
		cd "$(find * -type d | fzf)"
	else
		cd "$(find * -type d | fzf -q $1)"
	fi
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
