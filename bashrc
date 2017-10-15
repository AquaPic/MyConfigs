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

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    color_host_name='\[\033[38;5;3m\]'
else
    color_host_name='\[\033[38;5;10m\]'
fi

PROMPT_COMMAND=set_prompt

set_prompt () {
    exit_status=$?
    get_working_directory
    process_exit_status
    [ -n "$include_git_status" ] && get_git_status || git_status=""
    PS1="\[$(tput sgr0)\][\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\[$color_host_name\]\h\[$(tput sgr0)\]:\[\033[38;5;14m\]\[$working_directory\]\[$(tput sgr0)\]]\[$git_status\]\[$exit_status\]\\$\[$(tput sgr0)\] "
}

get_git_status () {
    branch=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    if [[ -n $branch ]]; then
        git_status=`git status -s | awk '{print $1}' | sort -u | awk '{printf(" %s", $1)}'`
        git_status="\[$(tput sgr0)\]\[\033[38;5;8m\](\[$branch\]\[$(tput sgr0)\]\[\033[38;5;1m\]\[$git_status\]\[$(tput sgr0)\]\[\033[38;5;8m\])\[$(tput sgr0)\]"
    else
        git_status=""
    fi
}

process_exit_status () {
    if [ $exit_status -eq 0 ]; then
        exit_status=""
    else
        exit_status="\[$(tput sgr0)\]\[\033[38;5;1m\]<\[$exit_status\]>\[$(tput sgr0)\]"
    fi
}

get_working_directory () {
    case $PWD in
        $HOME)
            working_directory="~"
            ;;
        $HOME/*/*/*)
            working_directory="~/../${PWD#"${PWD%/*/*}/"}"
            ;;
        $HOME/*/*)
            working_directory="~/${PWD#"${PWD%/*/*}/"}"
            ;;
        $HOME/*)
            working_directory="~/${PWD##*/}"
            ;;
        /*/*/*)
            working_directory="../${PWD#"${PWD%/*/*}/"}"
            ;;
        *)
            working_directory="$PWD"
            ;;
    esac
}

#PS1="[\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\[\033[38;5;10m\]\h\[$(tput sgr0)\]:\[\033[38;5;14m\]\w\[$(tput sgr0)\]]\\$ \[$(tput sgr0)\]"
