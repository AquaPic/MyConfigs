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

# common aliases
alias ls='ls -lh --color'
alias la='ls -alh --color'
alias ll='ls -alh --color | less -RX'
alias cls='cd; clear;'
alias dirs='dirs -v'
alias ps='ps -elf'
alias etar='tar xvzf'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# add ~/bin to PATH if it exists
if [ -d ~/bin ]; then
    PATH=$PATH:~/bin
fi

# add ~/bin-local to PATH if it exists
if [ -d ~/bin-local ]; then
    PATH=$PATH:~/bin-local
fi

# execute ~/.bashrc-local if it exists
if [ -f ~/.bashrc-local ]; then
    . ~/.bashrc-local
fi

# now export PATH because .bashrc-local might add some execution paths
export PATH

PROMPT_COMMAND=set_prompt

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    color_host_name='\[\033[38;5;3m\]'
else
    color_host_name='\[\033[38;5;10m\]'
fi

set_prompt () {
    exit_status=$?
    #get_working_directory
    process_exit_status
    [ -n "$include_git_status" ] && get_git_status || git_status=""
    PS1="\[$(tput sgr0)\][\[\033[38;5;10m\]\u\[$(tput sgr0)\]@\[$color_host_name\]\h\[$(tput sgr0)\]:\[\033[38;5;14m\]\w\[$(tput sgr0)\]]\[$git_status\]\[$exit_status\]\\n \$\[$(tput sgr0)\] "
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
set_prompt

