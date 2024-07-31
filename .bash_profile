# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"


# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

set horizontal-scroll-mode on

function clear() {
	printf "\33c\e[3J"
}
export -f clear

set -o vi
alias ls='ls -GF'
alias ..g='git rev-parse && cd "$(git rev-parse --show-cdup)"'
