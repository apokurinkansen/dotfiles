# dotfiles

個人用の設定ファイル管理リポジトリ。

## 前提

- OS: macOS（Intel / Apple Silicon どちらも対応）
- シェル: zsh

## 含まれる設定

| ファイル                             | 説明                                   |
| ------------------------------------ | -------------------------------------- |
| `.zshrc`                             | シェル設定                             |
| `Brewfile`                           | Homebrewでインストールするパッケージ   |
| `.config/mise/config.toml`           | mise設定（グローバルPythonバージョン） |
| `.config/uv/uv.toml`                 | uv設定                                 |
| `.config/uv/uv-tools.txt`            | uvでインストールするツール             |
| `.config/zellij/config.kdl`          | Zellij設定                             |
| `.config/zellij/layouts/default.kdl` | Zellijレイアウト                       |
| `.config/ghostty/config`             | Ghostty設定                            |
| `.config/starship.toml`              | Starshipプロンプト設定                 |
| `.config/nvim/`                      | Neovim設定                             |
| `.claude/CLAUDE.md`                  | Claude Codeカスタム指示                |
| `.claude/settings.json`              | Claude Code設定                        |
| `.claude/skills/`                    | Claude Codeスキル                      |
| `.claude/sounds/`                    | Claude Code通知音                      |
| `.claude/statusline.sh`              | Claude Codeステータスライン            |

※ `.claude/` 以下はユーザーレベル設定（`~/.claude/`）。このため dotfiles プロジェクト固有の Claude Code 設定は作成できない。必要になった場合は構造の見直しが必要。

## セットアップ

```bash
git clone https://github.com/tanuuuuuuu/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
source ~/.zshrc
```

## setup.sh がやること

1. Homebrew をインストール（未インストールの場合）
2. `Brewfile` のパッケージをインストール
3. mise で Python をインストール
4. uv をインストール
5. `.config/uv/uv-tools.txt` に記載されたツールをインストール
6. シンボリックリンクを作成（`.zshrc`, `.config/`, `.claude/`）
