function fzf_setup_using_base_dir() {
  local fzf_base fzf_shell fzfdirs dir

  test -d "${FZF_BASE}" && fzf_base="${FZF_BASE}"

  if [[ -z "${fzf_base}" ]]; then
    fzfdirs=(
      "${HOME}/.fzf"
      "/opt/homebrew/opt/fzf"
    )
    for dir in ${fzfdirs}; do
      if [[ -d "${dir}" ]]; then
        fzf_base="${dir}"
        break
      fi
    done
  fi

  if [[ ! -d "${fzf_base}" ]]; then
    return 1
  fi

  # Fix fzf shell directory for Arch Linux, NixOS or Void Linux packages
  if [[ ! -d "${fzf_base}/shell" ]]; then
    fzf_shell="${fzf_base}"
  else
    fzf_shell="${fzf_base}/shell"
  fi

  # Setup fzf binary path
  if (( ! ${+commands[fzf]} )) && [[ "$PATH" != *$fzf_base/bin* ]]; then
    export PATH="$PATH:$fzf_base/bin"
  fi

  # Auto-completion
  if [[ -o interactive ]]; then
    source "${fzf_shell}/completion.zsh" 2> /dev/null
  fi

  # Key bindings
  source "${fzf_shell}/key-bindings.zsh"
}

function fzf_setup_error() {
  cat >&2 <<'EOF'
fzf plugin: Cannot find fzf installation directory.
Please add `export FZF_BASE=/path/to/fzf/install/dir` to your .zshrc
EOF
}

fzf_setup_using_base_dir \
  || fzf_setup_error

unset -f -m 'fzf_setup_*'

if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  fi
fi

# Not working in tmux, so commented out for now
# export FZF_COMPLETION_TRIGGER=','
# function _fzf_compgen_path() {
#   fd --hidden --follow --exclude .git --exclude node_modules --exclude .hg --exclude .svn . "$1"
# }
# function _fzf_compgen_dir() {
#   fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude .hg --exclude .svn . "$1"
# }

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:4,hl+:#5fd7ff,info:#5fd7ff,marker:2
  --color=prompt:2,spinner:5,pointer:6,header:4
  --color=gutter:#000000,border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="❯ "
  --marker="+" --pointer="-" --separator="─" --scrollbar="│"
  --layout=reverse
'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
--bind 'ctrl-d:preview-down,ctrl-u:preview-up'
"
