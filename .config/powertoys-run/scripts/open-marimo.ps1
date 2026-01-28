# Desktopでスタンドアロンのmarimoノートブックを開く
# PowerToys Run から実行可能
# 引数: notebook name (オプション、デフォルト: my_notebook)

param(
    [string]$NotebookName = "my_notebook"
)

# PATHを設定（PowerToys Run実行時に環境変数が読み込まれない場合に備える）
$env:Path = "$env:USERPROFILE\.local\bin;$env:Path"

# Desktopに移動
$desktopPath = [Environment]::GetFolderPath("Desktop")
Set-Location $desktopPath

# marimoを起動
$notebookFile = "${NotebookName}.py"
uvx marimo edit --sandbox $notebookFile
