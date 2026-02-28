# dotfiles

macOS / Windows (WSL Ubuntu) 対応の個人設定ファイル管理リポジトリ。

> **注意**: Windows環境ではWSLのUbuntuを使用します。PowerShellは使用しません。

## 技術スタック

### macOS
- OS: macOS
- シェル: zsh
- パッケージ管理: Homebrew
- ランタイム管理: mise
- Python パッケージ管理: uv
- エディタ: Neovim
- プロンプト: Starship
- ターミナルマルチプレクサ: Zellij
- ターミナルエミュレータ: Ghostty
- ランチャー: Raycast
- コーディングエージェント: Claude Code

### Windows (WSL Ubuntu)
- OS: Windows 10/11 + WSL2
- シェル: zsh (Ubuntu内)
- パッケージ管理: Homebrew (Linux版)
- ランタイム管理: mise
- Python パッケージ管理: uv
- エディタ: Neovim
- プロンプト: Starship
- ターミナルマルチプレクサ: Zellij
- ターミナルエミュレータ: Windows Terminal (WSL Ubuntu接続)
- コーディングエージェント: Claude Code

## 構造

### macOS / WSL Ubuntu (共通)
- `.zprofile` - ログインシェル設定
- `.zshrc` - インタラクティブシェル設定
- `Brewfile` - Homebrew パッケージ一覧（共通）
- `Brewfile.macos` - macOS 専用パッケージ（tap, cask 含む）
- `Brewfile.linux` - Linux 専用パッケージ
- `.config/` - 各種ツールの設定
- `.claude/` - Claude Code の設定（スキル含む）
- `setup.sh` - 初期セットアップスクリプト（macOS/WSL共通）

### macOS 専用
- `macos.sh` - macOS システム設定（defaults コマンド）
- `.config/ghostty/` - Ghostty ターミナル設定
- `.config/raycast/` - Raycast スクリプト

### Windows 専用
- `windows.sh` - Windows システム設定（WSL から reg.exe で実行）
- `.config/windows-terminal/` - Windows Terminal 設定（WSL Ubuntu用）

## リポジトリ配置

- ローカルリポジトリは `~/repos/` で管理
- dotfiles のみ例外として `~/dotfiles/` に配置（慣習的にわかりやすいため）

## 作業ルール

- シンボリックリンクで管理されるファイルは直接編集しない
- ディレクトリ構造を変更した場合は CLAUDE.md と README.md の整合性を確認・更新する
- `.config/` および `.claude/` 以下はミラーリング方式（実際の配置場所と同じ構造）で管理する
- `.claude/` はユーザーレベル設定として `~/.claude/` にリンクされるため、このプロジェクト固有の Claude Code 設定は作成できない（必要になった場合は構造の見直しが必要）
- コミット前に機密情報（APIキー、トークン等）が含まれていないか確認する
