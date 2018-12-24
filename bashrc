# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# random functions that might be useful on a temp basis
if [ -d ~/.bash-sources ]; then
    for f in $(find ~/.bash-sources/*.sh); do
        source "$f";
    done
fi;

function timer_start {
  rc=$?
  timer=${timer:-$SECONDS}
  return $rc
}

function timer_stop {
  rc=$?
  timer_show=$(($SECONDS - $timer))
  unset timer
  return $rc
}

function timer_print {
    rc=$?
    if [ ${timer_show} -gt "120" ]; then
        printf "\e[38;5;124m[${timer_show}]\e[m "
    elif [ ${timer_show} -gt "60" ]; then
        printf "\e[38;5;214m[${timer_show}]\e[m "
    else
        printf "\e[38;5;118m[${timer_show}]\e[m "
    fi
    return $rc
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
  PROMPT_COMMAND="timer_stop"
elif [[ "$PROMPT_COMMAND" != *"timer_stop"* ]]; then
  PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

PS1='[\A] \[\e[38;5;118m\]\u \[\e[38;5;45m\]\w\[\e[38;5;196m\]$(__git_ps1 " (%s)") \[\e[38;5;166m\]$?\[\e[m\] $(timer_print)\\$ '
DEFAULT_PS1="$PS1"

function set_alerting {
    case $1 in
        on) PS1="$PS1\a";;
       off) PS1="$DEFAULT_PS1";;
         *) PS1="$PS1\a";;
    esac
    return 0;
}


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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -lFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias tmux='tmux -2'

export EDITOR=vim
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
export PATH="$PATH:$HOME/scripts"
export PYTHONPATH="$PYTHONPATH:$HOME/scripts/python"
export PYTHONDONTWRITEBYTECODE=1
export PAGER=less
export GOPATH=/opt/go

# functional/settings aliases
alias vimPlugins='vim +PluginInstall +qall'
alias less='less -R'
alias stripcolors='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'
alias norm='tput cnorm'
alias invis='tput cinvs'
alias raspberry='ssh pi@raspberrypi'

# random application settings
alias spotify='spotify --force-device-scale-factor=2.5'
alias google-chrome='google-chrome --force-device-scale-factor=2'


# convenience aliases
alias pypiu='python setup.py sdist upload -r local'

