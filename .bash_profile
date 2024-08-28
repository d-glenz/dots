#!/usr/bin/bash
# .bash_profile


# if [ -f ~/.bashrc ]; then
#     . ~/.bashrc
# fi

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

set -o vi
shopt -s lithist

if [[ -d ~/bash-configs ]]; then
    . ~/bash-configs/git-completion.bash
    . ~/bash-configs/variables
    . ~/bash-configs/aliases
    . ~/bash-configs/functions
    . ~/bash-configs/ps1-timer
    . ~/bash-configs/binds
    . ~/bash-configs/x11
fi

if [[ -d ~developer/tools ]]; then
    # developer machine specific
    . /home/developer/tools/fzf/0.24.2/shell/key-bindings.bash
    . /home/developer/tools/fzf/0.24.2/shell/completion.bash
fi


source /opt/optiver/bin/git-prompt.sh
if [[ -f ~/.local/bin/virtualenvwrapper_lazy.sh ]]; then
	source ~/.local/bin/virtualenvwrapper_lazy.sh
elif [[ -f /usr/bin/virtualenvwrapper_lazy.sh ]]; then
	source /usr/bin/virtualenvwrapper_lazy.sh 
fi
use_devtoolset_8
use_toolbox  # enable toolbox bash stuff

# ssh agent start
SSH_ENV="$HOME/.ssh/agent-environment"

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
bind -m vi-insert "\C-l":clear-screen  # C-l -> clear screen in input mode
