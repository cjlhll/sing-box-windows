@echo off
chcp 65001 > nul
:: 设置脚本当前目录为工作目录
cd /d %~dp0

:: 停止服务
echo 正在停止服务...
winsw.exe stop
if %errorlevel% neq 0 (
    echo 服务停止失败！
    pause
    exit /b %errorlevel%
)

:: 卸载服务
echo 正在卸载服务...
winsw.exe uninstall
if %errorlevel% neq 0 (
    echo 服务卸载失败！
    pause
    exit /b %errorlevel%
)

echo 服务停止并卸载成功！
pause
