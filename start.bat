@echo off
chcp 65001 > nul

cd /d %~dp0

:: 执行当前目录下的 download.bat
call download.bat

:: 检查脚本是否以管理员权限运行
net session >nul 2>&1
if %errorLevel% == 0 (
    echo 管理员权限已检测到。正在以提升的权限运行 sing-box.exe...
    sing-box.exe run
) else (
    echo 错误：此脚本需要管理员权限才能运行。
    echo 请以管理员身份重新运行此脚本。
)

pause
