Get-Content .env | ForEach-Object {
    $key, $value = $_.Split("=", 2)
    Set-Item -Path Env:$key -Value $value
}