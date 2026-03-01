# ==================================================
# Homebrew
# ==================================================
if [[ -f /opt/homebrew/bin/brew ]]; then
  # Apple Silicon Mac
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  # Intel Mac
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  # Linux (WSL含む)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ==================================================
# uv（グローバル CLI ツール）
# ==================================================
export PATH="$HOME/.local/bin:$PATH"

# ==================================================
# Google Cloud SDK
# ==================================================
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then
  . "$HOME/google-cloud-sdk/path.bash.inc"
fi

# ==================================================
# .bashrc の読み込み
# ==================================================
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
