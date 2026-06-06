#!/usr/bin/env bash

# This script is used to bootstrap the environment before running install scripts.
# It is meant to be copy-pasted into a file and run.
# Prerequisites:
# - Another bitwarden application open with the user logged in (e.g. desktop app or browser extension or smartphone app)

set -e

echo "Bootstrapping environment..."
echo

# if homebrew is installed, skip installation
if command -v brew &> /dev/null; then
    echo "Homebrew is already installed, skipping installation."
    echo
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)" # give homebrew to the current shell session
    echo "Homebrew installed successfully. You need to add .zprofile for brew yourself"
fi

if command -v bw &> /dev/null && command -v jq &> /dev/null; then
    echo "Bitwarden CLI and jq are already installed, skipping installation."
    echo
else
    brew install bitwarden-cli jq
fi

export BW_SESSION=$(bw login --raw)

mkdir -p ~/.ssh && chmod 700 ~/.ssh

BW_GHUB_ID="2cf6ad5b-46e3-415b-ac8f-b2b900dd4ec5"

json=$(bw get item $BW_GHUB_ID)
file_name=$(echo "$json" | jq -r '.fields[] | select(.name == "file_name") | .value')
echo "$json" | jq -r '.sshKey.privateKey' > ~/.ssh/$file_name
echo "$json" | jq -r '.sshKey.publicKey' > ~/.ssh/$file_name.pub
chmod 600 ~/.ssh/$file_name
chmod 644 ~/.ssh/$file_name.pub

# Update the ssh config file to use the new key for github.com
echo "Configuring SSH for github.com..."
if ! grep -q "Host github.com" ~/.ssh/config 2>/dev/null; then
    echo "Host github.com" >> ~/.ssh/config
    echo "  AddKeysToAgent yes" >> ~/.ssh/config
    echo "  IdentityFile ~/.ssh/$file_name" >> ~/.ssh/config
    echo "Added SSH configuration for github.com"
else
    echo "SSH configuration for github.com already exists, skipping."
fi

echo "Cloning dotfiles repository..."
git clone git@github.com:susumantan/.dotfiles.git $HOME/.dotfiles

echo "Bootstrapping complete!"

# Cleanup
unset BW_SESSION

brew uninstall --force bitwarden-cli jq