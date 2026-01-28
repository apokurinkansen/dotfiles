# Zettelkasten の Zettel ID を作成する
# PowerToys Run から実行可能

# クリップボードから内容を取得
Add-Type -AssemblyName System.Windows.Forms
$clipboardContent = [System.Windows.Forms.Clipboard]::GetText()

# 日付フォーマットの正規表現パターン (YYYY-MM-DDThh:mm:ss+hh:mm)
$datePattern = '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}[+-]\d{2}:\d{2}$'

# クリップボードの内容が正しいフォーマットかチェック
if ($clipboardContent -match $datePattern) {
    # タイムゾーン部分を修正（:を削除してDateTimeに適合させる）
    $inputDate = $clipboardContent -replace '([+-]\d{2}):(\d{2})$', '$1$2'
    try {
        $dateTime = [DateTimeOffset]::ParseExact($inputDate, "yyyy-MM-ddTHH:mm:sszzz", $null)
    } catch {
        # パースに失敗した場合は現在時刻を使用
        $dateTime = [DateTimeOffset]::Now
    }
} else {
    # フォーマットが合わない場合は現在時刻を使用
    $dateTime = [DateTimeOffset]::Now
}

# Zettel ID を生成 (YYYYMMDDHHmm)
$zettelId = $dateTime.ToString("yyyyMMddHHmm")

# 結果をクリップボードにコピー
[System.Windows.Forms.Clipboard]::SetText($zettelId)

# 結果を表示
Write-Host "Zettel ID: $zettelId" -ForegroundColor Green
Write-Host "クリップボードにコピーしました" -ForegroundColor Cyan
