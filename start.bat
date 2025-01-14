@echo off
chcp 65001 > nul
:: 设置脚本当前目录为工作目录
cd /d %~dp0

:: 执行安装
echo 正在安装服务...
winsw.exe install
if %errorlevel% neq 0 (
    echo 服务安装失败！
    pause
    exit /b %errorlevel%
)

:: 启动服务
echo 正在启动服务...
winsw.exe start
if %errorlevel% neq 0 (
    echo 服务启动失败！
    pause
    exit /b %errorlevel%
)

echo 服务安装并启动成功！
pause
