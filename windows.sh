#!/bin/bash
#
# Windows settings via registry (run from WSL)
# Run: ./windows.sh
#
# Note: Some changes require logout/restart to take effect
#

set -e

# Check if running on WSL
if [[ ! -f /proc/version ]] || ! grep -qi microsoft /proc/version; then
    echo "Error: This script must be run on WSL"
    exit 1
fi

REG="/mnt/c/Windows/System32/reg.exe"

echo "Applying Windows settings..."

# ==================================================
# Keyboard
# ==================================================

# キーリピート速度 (0-31, 31が最速)
$REG add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d "31" /f

# キーリピート開始までの時間 (0-3, 0が最短)
$REG add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d "0" /f

# CapsLock を Ctrl に変更
# Scancode Map: 00000000 00000000 02000000 1d003a00 00000000
# (2 keys remapped: CapsLock(0x3a) -> Left Ctrl(0x1d))
$REG add "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d "00000000000000000200000001003a0000000000" /f 2>/dev/null || \
    echo "Note: CapsLock remap requires admin. Run as administrator or use PowerToys."

# ==================================================
# Explorer
# ==================================================

# 隠しファイルを表示 (1=表示, 2=非表示)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f

# 拡張子を表示 (0=表示, 1=非表示)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

# フォルダを常に先頭に表示 (1=有効)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v FolderSepProcess /t REG_DWORD /d 1 /f

# ==================================================
# Appearance
# ==================================================

# ダークモード - アプリ (0=ダーク, 1=ライト)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f

# ダークモード - システム (0=ダーク, 1=ライト)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

# ==================================================
# Taskbar
# ==================================================

# タスクバー自動非表示 (1=有効, 0=無効)
# Settings binary format: 03がビット列、bit 0=タスクバーロック, bit 1=自動非表示
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v Settings /t REG_BINARY /d "30000000feffffff0200000003000000" /f 2>/dev/null || true

# 検索ボックス (0=非表示, 1=アイコンのみ, 2=検索ボックス表示)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

# タスクビューボタン非表示 (0=非表示, 1=表示)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f

# Copilot ボタン非表示 (Windows 11) (0=非表示, 1=表示)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f 2>/dev/null || true

# ウィジェットボタン非表示 (Windows 11) (0=非表示, 1=表示)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f 2>/dev/null || true

# チャットボタン非表示 (Windows 11) (0=非表示, 1=表示)
$REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f 2>/dev/null || true

# ==================================================
# Power
# ==================================================

# 高速スタートアップ無効化 (0=無効, 1=有効)
# Note: This requires admin privileges
$REG add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f 2>/dev/null || \
    echo "Note: Fast startup setting requires admin privileges."

# ==================================================
# Sound
# ==================================================

# 通知音を無効化
$REG add "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".None" /f

# 個別の通知音を無効化
for event in ".Default" "SystemAsterisk" "SystemExclamation" "SystemHand" "SystemNotification" "SystemQuestion" "Notification.Default"; do
    $REG add "HKCU\AppEvents\Schemes\Apps\.Default\\$event\\.Current" /ve /t REG_SZ /d "" /f 2>/dev/null || true
done

# ==================================================
# Apply changes
# ==================================================

echo ""
echo "Done!"
echo ""
echo "Note: Some settings require a restart to take effect:"
echo "  - CapsLock -> Ctrl remap"
echo "  - Taskbar auto-hide"
echo "  - Fast startup"
echo ""
echo "To restart Explorer (applies some changes immediately):"
echo "  taskkill.exe /f /im explorer.exe && explorer.exe"
