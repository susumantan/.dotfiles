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


export FZF_DEFAULT_OPTS=$'--color=fg:#c9d1d9,bg:#0d1117,hl:#79c0ff,fg+:#c9d1d9,bg+:#161b22
  --color=hl+:#a5d6ff,info:#8b949e,prompt:#58a6ff,pointer:#f85149
  --color=marker:#ff7b72,spinner:#3fb950,header:#79c0ff,border:#30363d
  --color=label:#8b949e,gutter:#161b22,footer:#8b949e'

# A more darker
# export FZF_DEFAULT_OPTS=$'--color=fg:#b2b2b2,bg:#080808,hl:#80a0ff,fg+:#c6c6c6,bg+:#1a1a2e
#   --color=hl+:#80a0ff,info:#36c692,prompt:#ae81ff,pointer:#ff5454
#   --color=marker:#ff8080,spinner:#79dac8,header:#74b2ff,border:#303030
#   --color=label:#686868,gutter:#1a1a2e,footer:#74b2ff'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
--prompt='❯ '
--pointer='-'
--marker='+'
--bind 'ctrl-alt-d:preview-down,ctrl-alt-u:preview-up,ctrl-d:page-down,ctrl-u:page-up'
"
