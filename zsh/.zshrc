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

if [ -d "$PLUGINS_DIR/fzf-git" ]; then
  source "$PLUGINS_DIR/fzf-git/fzf-git.sh"
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
[ -d "$HERD_PHP_PATH" ] && export PATH="$HERD_PHP_PATH:$PATH"

# Consolidated Herd injected PHP configuration.
for version in 74 80 81 82 83 84; do
  export "HERD_PHP_${version}_INI_SCAN_DIR=$HOME/Library/Application Support/Herd/config/php/${version}/"
done

# zoxide
eval "$(zoxide init zsh)"

# p10k prompt
source "$PLUGINS_DIR/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit $HOME/.config/p10k/p10k.zsh
[[ ! -f $HOME/.config/p10k/p10k.zsh ]] || source $HOME/.config/p10k/p10k.zsh
