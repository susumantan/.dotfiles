#!/usr/bin/env zsh

## This file contains all the extra functions or configuration
typeset -U path
path+=($HOME/bin)

# export FZF_COMPLETION_TRIGGER=','
# function _fzf_compgen_path() {
#   echo "$1"
#   bfs -follow "$1" \
#     -exclude -name .git -a -exclude -name node_modules -a -exclude -name .hg -exclude -name .svn -a \( -type d -o -type f -o -type l \) \
#     -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
# }
# function _fzf_compgen_dir() {
#   bfs -follow "$1" \
#     -exclude -name .git -a -exclude -name node_modules -a -exclude -name .hg -exclude -name .svn -a -type d \
#     -a -not -path "$1" -print 2> /dev/null | sed 's@^\./@@'
# }

# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
# --prompt='❯ '
# --pointer='-'
# --marker='+'
# --tabstop=4
# --color=dark
# --color=hl:2:bold,fg+:4:bold,bg+:-1,hl+:2:bold,info:3:bold,border:8,prompt:2,pointer:5,marker:1,header:6
# --bind 'ctrl-alt-d:preview-down,ctrl-alt-u:preview-up,ctrl-d:page-down,ctrl-u:page-up,::jump'
# "

export FZF_DEFAULT_OPTS=" \
--color=spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
--prompt='❯ '
--pointer='-'
--marker='+'
--bind 'ctrl-alt-d:preview-down,ctrl-alt-u:preview-up,ctrl-d:page-down,ctrl-u:page-up'
"
