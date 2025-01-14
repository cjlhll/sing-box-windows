
# 可以用winsw.exe配置sing-box.exe到开机服务里面 感谢此[文档](https://homing.so/blog/proxy/sing-box-on-windows)

## 下载本项目后，文件夹改名为 `sing-box` 放到D盘根目录

### 配置 sing-box 服务

编辑 `winsw.xml`，写入自己转换好的订阅连接：
```
<service>
  <id>sing-box</id>
  <name>sing-box</name>
  <description>This service runs sing-box continuous integration system.</description>
  <download from="https://你的订阅链接" to="%BASE%\config.json" auth="sspi" />
  <executable>D:\sing-box\sing-box.exe</executable>
  <arguments>run</arguments>
  <log mode="reset" />
  <onfailure action="restart" />
</service>
```

### 这里解释几个参数：


`<download>`：在指定的 `<executable>` 运行前，WinSW 会从指定的 URL 获取资源并将其作为文件放到本地。%BASE% 指向 WinSW 的目录，所以这里将订阅链接的内容重命名为 config.json 并放到当前目录下。
`<executable>`：指定要启动的可执行文件，这里指定为 Scoop 安装的 sing-box 的路径，这个路径可以在安装完 sing-box 之后使用：`whereis sing-box` 获取。
`<arguments>`：指定要传递给可执行文件的参数，这里传递的是 `run`。因为执行的位置就在当前路径，所以不需要指定 config.json 的路径。
完成后，使用 `./winsw.exe -h` 可以查看 WinSW 的所有指令：

```
./winsw.exe -h
```

执行 `start.bat` 脚本启动，以后开机会自启动<br>
执行 `stop.bat` 脚本停止

```
2024-02-07 11:34:16,941 DEBUG - Starting WinSW in console mode
2024-02-07 11:34:19,748 DEBUG - Starting WinSW in console mode
2024-02-07 11:34:19,802 INFO  - Starting service 'sing-box (sing-box)'...
2024-02-07 11:34:20,512 DEBUG - Starting WinSW in service mode
2024-02-07 11:34:20,559 INFO  - Service 'sing-box (sing-box)' started successfully.
2024-02-07 11:34:20,629 INFO  - Downloading: https://你的订阅链接 to C:\Users\homin\workspace\sing-box\config.json. failOnError=False
2024-02-07 11:34:23,004 INFO  - Starting C:\Users\homin\scoop\shims\sing-box.exe run
2024-02-07 11:34:23,043 INFO  - Started process 27484
2024-02-07 11:34:23,063 DEBUG - Forwarding logs of the process System.Diagnostics.Process (sing-box) to WinSW.ResetLogAppender
```

而目录中的 `winsw.out.log` 保存了 sing-box 运行时产生的日志。

到这里，我们已经实现了在 Windows 上无感使用 sing-box，并且实现自动更新订阅。
