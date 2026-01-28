# スクリーンショットを全て削除する
# PowerToys Run から実行可能

# documents/screenshot ディレクトリのパス
$screenshotDir = "$env:USERPROFILE\Documents\screenshot"

# ディレクトリが存在するかチェック
if (-not (Test-Path $screenshotDir)) {
    Write-Host "エラー: ディレクトリ '$screenshotDir' が存在しません" -ForegroundColor Red
    exit 1
}

# ディレクトリ内のファイル数をカウント
$files = Get-ChildItem -Path $screenshotDir -File
$fileCount = $files.Count

# ファイルが存在しない場合
if ($fileCount -eq 0) {
    Write-Host "削除対象のファイルがありません" -ForegroundColor Yellow
    exit 0
}

# ファイルを削除
$files | Remove-Item -Force

# 結果を表示
Write-Host "削除完了: $fileCount 個のファイルを削除しました" -ForegroundColor Green
