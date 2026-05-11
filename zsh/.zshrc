# Auto-load all zsh plugins from ~/.config/zsh/plugins
PLUGINS_DIR="$HOME/.config/zsh/plugins"

if [ -d "$PLUGINS_DIR" ]; then
  for plugin_file in "$PLUGINS_DIR"/**/*.plugin.zsh(N); do
    [ -r "$plugin_file" ] && source "$plugin_file"
  done
fi

if [ -d "$HOME/.config/zsh/plugins/fzf-git" ]; then
  source "$HOME/.config/zsh/plugins/fzf-git/fzf-git.sh"
fi

# Preferred editor
if command -v vim >/dev/null 2>&1; then
  export EDITOR='vim'
fi 

source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/profile.zsh"
# source "$HOME/.config/zsh/functions.zsh"

# If you need to have a local .zsh_profile, create ~/.zsh_profile.local on your home directory
[[ ! -f ~/.zsh_profile.local ]] || source ~/.zsh_profile.local


# fnm
export FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$HOME/.local/share/fnm:$PATH"
  eval "`fnm env --use-on-cd --shell zsh`"
fi

# zoxide
eval "`zoxide init zsh`"

# Herd
export HERD_PHP_PATH="$HOME/Library/Application Support/Herd/bin"
if [ -d "$HERD_PHP_PATH" ]; then
  export PATH="$HERD_PHP_PATH:$PATH"
fi

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/susumantan/Library/Application Support/Herd/config/php/84/"

# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/susumantan/Library/Application Support/Herd/config/php/85/"


# Herd injected PHP 7.4 configuration.
export HERD_PHP_74_INI_SCAN_DIR="/Users/susumantan/Library/Application Support/Herd/config/php/74/"

# Added by Antigravity
export PATH="/Users/susumantan/.antigravity/antigravity/bin:$PATH"

# Starship prompt
eval "$(starship init zsh)"
