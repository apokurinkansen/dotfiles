#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Homebrew インストール確認
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# zsh-autosuggestions インストール
if ! brew list zsh-autosuggestions &> /dev/null; then
    echo "Installing zsh-autosuggestions..."
    brew install zsh-autosuggestions
fi

# uv インストール確認
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Python 3.13 インストール
uv python install 3.13

# シンボリックリンク作成
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.python-version" ~/.python-version
mkdir -p ~/.config/uv
ln -sf "$DOTFILES_DIR/uv/uv.toml" ~/.config/uv/uv.toml

# グローバルツールのインストール
if [ -f "$DOTFILES_DIR/uv/tools.txt" ]; then
    while IFS= read -r tool || [ -n "$tool" ]; do
        # コメント行と空行をスキップ
        [[ "$tool" =~ ^#.*$ || -z "$tool" ]] && continue
        echo "Installing $tool..."
        uv tool install "$tool"
    done < "$DOTFILES_DIR/uv/tools.txt"
fi

echo "Setup complete! Run 'source ~/.zshrc' to apply changes."
