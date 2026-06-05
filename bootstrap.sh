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

echo "Environment bootstrapped successfully!"
echo "Next steps:"
echo "1. Clone the dotfiles repository"
echo "2. Run the install script"