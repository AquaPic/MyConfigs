#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PATH=$PATH:~/bin
if [ -d ~/bin-local ]; then
    PATH=$PATH:~/bin-local
fi
export PATH

export BROWSER=/usr/bin/chromium
export EDITOR=/usr/bin/vim

alias ls='ls -l --color'
alias la='ls -al --color'
alias ll='ls -al --color | less -RX'
alias cls='clear'
alias dirs='dirs -v'
alias mysqld='sudo mysqld -u mysql'
alias ps='ps -elf'
alias etar='tar xvzf'
alias update='sudo pacman -Syyu'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [ -f .bashrc-local ]; then
    . ./.bashrc-local
fi

PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\[\033[38;5;10m\]\h\[$(tput sgr0)\]:\[\033[38;5;14m\]\w\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"
