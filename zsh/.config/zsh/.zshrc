#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U path
path+=($HOME/bin)
path+=($HOME/.local/bin) # Local bin

# Auto-load all zsh plugins from $ZDOTDIR/plugins
PLUGINS_DIR="$ZDOTDIR/plugins"

if [ -d "$PLUGINS_DIR" ]; then
  for plugin_file in "$PLUGINS_DIR"/**/*.plugin.zsh(N) "$PLUGINS_DIR"/**/fzf-git.sh(N); do
    [ -r "$plugin_file" ] && source "$plugin_file"
  done
fi

source "$ZDOTDIR/aliases.zsh"

# If you need to have a local .zprofile, create ~/.zprofile.local and it will be sourced automatically.
[[ ! -f ~/.zprofile.local ]] || source ~/.zprofile.local

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Here are the rules for herd:
# 1. If you need to install a php version, install it with herd and then quit herd.
# 2. When herd is installed first time, it will auto install latest php version and set it as the default "php" command.
# 3. You can use php74 or php80, but it needs to be installed with herd first!
HERD_BIN_DIR="$HOME/Library/Application Support/Herd/bin"
HERD_CONFIG_DIR="$HOME/Library/Application Support/Herd/config"
if [ -d "$HERD_BIN_DIR" ]; then
  # Loop through all php versions installed with herd and add them to PATH
  for php_version_dir in "$HERD_CONFIG_DIR/php/"*/; do
    php_version=$(basename "$php_version_dir")
    export "HERD_PHP_${php_version//./_}_BIN_DIR=$HERD_BIN_DIR/php/$php_version/bin"
  done
  path+=($HERD_BIN_DIR)
fi

# p10k prompt
[[ ! -f $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme ]] || source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit $XDG_CONFIG_HOME/p10k/p10k.zsh
[[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}/p10k/p10k.zsh" ]] || source "${XDG_CONFIG_HOME:-$HOME/.config}/p10k/p10k.zsh"