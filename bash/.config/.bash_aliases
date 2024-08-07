### General bash aliases ###
alias ll="ls -l"
alias ll="ls -l"
alias la="ls -A"
alias lal="ls -lA"
alias cd..="cd .."
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias nv="nvim"

### tmux aliases ###
alias ta="tmux attach"
alias tat="tmux attach -t"
alias tls="tmux ls"
alias tns="tmux new-session -t"
alias td="tmux detach"
alias tkill="tmux kill-session -t"

### git aliases ###
alias graph="git log --oneline --all --decorate --graph"

### ssh aliases ###
alias agent-ssh-start='ssh-agent -s > ~/.ssh/log.txt;eval `ssh-agent -s`'
alias add-ssh-abraxas="ssh-add ~/.ssh/abraxas_rsa"
alias abraxas="agent-ssh-start;add-ssh-abraxas"

