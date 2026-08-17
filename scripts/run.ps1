# scripts/run.ps1 - 本地编译并运行一道 ACM 题
#
# 用法:
#   .\scripts\run.ps1 .\mhy\2026-03-14\Q1
#
# 行为:
#   1. 编译 main.cpp (C++17)
#   2. 用 input.txt 作为 stdin 运行程序
#   3. 显示程序输出与退出码
#   4. 若存在 expected.txt, 显示期望输出并做简单比对

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$ProblemDir
)

$ErrorActionPreference = 'Stop'

# ---- 1. 校验参数与文件 ----
$resolved = Resolve-Path -LiteralPath $ProblemDir -ErrorAction Stop
$ProblemDir = $resolved.Path

$mainCpp = Join-Path $ProblemDir 'main.cpp'
$inputFile = Join-Path $ProblemDir 'input.txt'
$expectedFile = Join-Path $ProblemDir 'expected.txt'

if (-not (Test-Path -LiteralPath $mainCpp)) {
    Write-Host "[run] 缺少 main.cpp: $mainCpp" -ForegroundColor Red
    exit 1
}
if (-not (Test-Path -LiteralPath $inputFile)) {
    Write-Host "[run] 缺少 input.txt: $inputFile" -ForegroundColor Red
    exit 1
}

# ---- 2. 查找编译器 ----
$gpp = Get-Command g++ -ErrorAction SilentlyContinue
if (-not $gpp) {
    Write-Host "[run] 未找到 g++。请安装 MinGW-w64 并加入 PATH, 或改用 WSL。" -ForegroundColor Red
    exit 1
}

# ---- 3. 编译 ----
$exe = Join-Path $ProblemDir 'main.exe'
Write-Host "[run] 编译: $mainCpp"
& $gpp.Source -std=c++17 -O2 -Wall -Wextra $mainCpp -o $exe
if ($LASTEXITCODE -ne 0) {
    Write-Host "[run] 编译失败 (退出码 $LASTEXITCODE)" -ForegroundColor Red
    exit $LASTEXITCODE
}

# ---- 4. 运行 (PowerShell 5.1 不支持 '<' 输入重定向, 用 .NET 重定向 stdin) ----
Write-Host "[run] 运行: $exe  <  $inputFile"

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $exe
$psi.UseShellExecute = $false
$psi.RedirectStandardInput = $true
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.StandardOutputEncoding = [System.Text.Encoding]::UTF8
$psi.StandardErrorEncoding = [System.Text.Encoding]::UTF8

$proc = New-Object System.Diagnostics.Process
$proc.StartInfo = $psi
[void]$proc.Start()

$outTask = $proc.StandardOutput.ReadToEndAsync()
$errTask = $proc.StandardError.ReadToEndAsync()

try {
    $inputText = [System.IO.File]::ReadAllText($inputFile, [System.Text.Encoding]::UTF8)
    $proc.StandardInput.Write($inputText)
    $proc.StandardInput.Close()
} catch {
    # 程序可能在读完输入之前就退出了, 忽略管道写入错误
}

$proc.WaitForExit()

$stdout = $outTask.Result
$stderr = $errTask.Result

Write-Host "----------------------------------------"
Write-Host "[run] 程序输出:"
Write-Host $stdout -NoNewline
if ($stderr) {
    Write-Host "[run] 错误输出 (stderr):" -ForegroundColor Yellow
    Write-Host $stderr -NoNewline -ForegroundColor Yellow
}
Write-Host "[run] 退出码: $($proc.ExitCode)"

# ---- 5. 期望输出 ----
if (Test-Path -LiteralPath $expectedFile) {
    $expected = [System.IO.File]::ReadAllText($expectedFile, [System.Text.Encoding]::UTF8)
    Write-Host "----------------------------------------"
    Write-Host "[run] 期望输出 (expected.txt):"
    Write-Host $expected -NoNewline

    $trimOut = $stdout.TrimEnd([char]13, [char]10, [char]32, [char]9)
    $trimExp = $expected.TrimEnd([char]13, [char]10, [char]32, [char]9)
    if ($trimOut -eq $trimExp) {
        Write-Host "[run] 比对: 一致" -ForegroundColor Green
    } else {
        Write-Host "[run] 比对: 不一致" -ForegroundColor Yellow
    }
}
