# ==================================================
# Python環境（uv）
# ==================================================
export PATH="$HOME/.local/bin:$PATH"

# ==================================================
# Google Cloud SDK
# ==================================================
if [ -f '/Users/tanu/google-cloud-sdk/path.zsh.inc' ]; then
  . '/Users/tanu/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/tanu/google-cloud-sdk/completion.zsh.inc' ]; then
  . '/Users/tanu/google-cloud-sdk/completion.zsh.inc'
fi

# ==================================================
# プラグイン
# ==================================================
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==================================================
# プロンプト（Starship）
# ==================================================
eval "$(starship init zsh)"

# ==================================================
# その他の設定
# ==================================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt correct

macism com.google.inputmethod.Japanese.Roman

# ==================================================
# エイリアス
# ==================================================
alias vim='nvim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ==================================================
# Zellij自動起動（Ghostty使用時のみ）
# ==================================================
if [[ "$TERM" == "xterm-ghostty" ]] && [[ -z "$ZELLIJ" ]]; then
    zellij
fi
