typeset -U path
path+=($HOME/bin)

alias ll='ls -lh'
alias la='ls -A'

alias md='mkdir -p'
alias rd='rmdir'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias :q='exit'
alias c='code'

export FZF_COMPLETION_TRIGGER=','
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
--prompt='❯ '
--pointer='-'
--marker='+'
--tabstop=4
--color=dark
--color=hl:2:bold,fg+:4:bold,bg+:-1,hl+:2:bold,info:3:bold,border:8,prompt:2,pointer:5,marker:1,header:6
--bind 'ctrl-alt-d:preview-down,ctrl-alt-u:preview-up,ctrl-d:page-down,ctrl-u:page-up,::jump'
"