@echo off
chcp 65001 > nul

:: 定义目标文件名和链接
set "filename=config.json"
set "url=https://v1.mk/Fh5GDJN"

:: 检查当前目录是否有curl命令
where curl >nul 2>nul
if not %errorlevel%==0 (
    echo 未找到curl工具，请先安装curl后再运行此脚本。
    pause
    exit /b
)

:: 使用curl下载文件
curl -L -o "%filename%" "%url%"
if %errorlevel%==0 (
    echo 文件已成功下载并保存为 %filename%。
) else (
    echo 下载失败，请检查链接是否有效或网络连接是否正常。
)