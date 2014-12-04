# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source ~/.bash/functions
source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

# use .commonrc for settings specific to one system
if [ -f ~/.dotfiles/commonrc ]; then
  source ~/.dotfiles/commonrc
fi

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# source: http://b.sricola.com/post/16174981053/bash-autocomplete-for-ssh
# parses .bash_history and attempts to autocomplete the host you are trying to SSH to
complete -W "$(echo $(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //'))" ssh

PATH="$PATH:/usr/local/opt/ruby/bin"

# Drush aliases
if [ -f ~/.drush/drush_bashrc ] ; then
 . ~/.drush/drush_bashrc
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set prompt color to red for root- green for all other users
if [ $(whoami) == "root" ]; then
  PROMPT_COLOR="31m"
else
  PROMPT_COLOR="32m"
fi

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;$PROMPT_COLOR\]\u@$(hostname -f)\[\033[00m\]:\[\033[01;34m\]\w\[\033[0m\]$(parse_git_branch)$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    export PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@$(hostname -f): \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
