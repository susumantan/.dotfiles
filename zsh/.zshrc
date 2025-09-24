# Auto-load all zsh plugins from ~/.config/zsh/plugins
PLUGINS_DIR="$HOME/.config/zsh/plugins"

if [ -d "$PLUGINS_DIR" ]; then
  for plugin_file in "$PLUGINS_DIR"/**/*.plugin.zsh(N); do
    [ -r "$plugin_file" ] && source "$plugin_file"
  done
fi

source "$HOME/.config/zsh/profile.zsh" # Custom profile

# fnm
export FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env --use-on-cd --shell zsh`"
fi

# zoxide
eval "`zoxide init zsh`"