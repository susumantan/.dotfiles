# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# If you need to have a local .zsh_profile, create ~/.zsh_profile.local on your home directory
[[ ! -f ~/.zsh_profile.local ]] || source ~/.zsh_profile.local

# Herd
export HERD_PHP_PATH="$HOME/Library/Application Support/Herd/bin"
if [ -d "$HERD_PHP_PATH" ]; then
  export PATH="$HERD_PHP_PATH:$PATH"
fi

# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"

# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/82/"

# Herd injected PHP 7.4 configuration.
export HERD_PHP_74_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/74/"

# Herd injected PHP 8.0 configuration.
export HERD_PHP_80_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/80/"

# Herd injected PHP 8.1 configuration.
export HERD_PHP_81_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/81/"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/83/"

# zoxide
eval "`zoxide init zsh`"

# p10k prompt
source "$HOME/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit $HOME/.config/p10k/p10k.zsh
[[ ! -f $HOME/.config/p10k/p10k.zsh ]] || source $HOME/.config/p10k/p10k.zsh
