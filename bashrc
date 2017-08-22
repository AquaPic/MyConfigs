#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH=$PATH:~/bin
if [ -d ~/bin-local ]; then
    PATH=$PATH:~/bin-local
fi
export PATH

export BROWSER=/usr/bin/chromium
export EDITOR=/usr/bin/vim

export school='brand399@207.93.211.84'
export server='root@149.56.109.90'

alias ls='ls -l --color'
alias la='ls -al --color'
alias ll='ls -al --color | less -RX'
alias cls='clear'
alias dirs='dirs -v'
alias sshschool='ssh $school'
alias sshserver='ssh $server'
alias mysqld='sudo mysqld -u mysql'
alias ps='ps -elf'
alias etar='tar xvzf'
alias update='sudo pacman -Syyu'

PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\[\033[38;5;10m\]\h\[$(tput sgr0)\]:\[\033[38;5;14m\]\w\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"
