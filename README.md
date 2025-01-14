### 两种执行方法
# 可以用winsw.exe配置sing-box.exe到开机服务里面 [文档](https://homing.so/blog/proxy/sing-box-on-windows)
```
# 如果你使用 Scoop
scoop install sing-box
# 如果你使用 Chocolatey
choco install sing-box
```
### 配置 sing-box 服务
如果每次使用 sing-box 都得打开 terminal 的话也太烦人，所以最好是将它配置成一个 Windows 的服务，这样我们就不用每次重启还要手动运行了，把这些工作都交给 Windows！为了实现这个目的，我们要用到 [WinSW](https://github.com/winsw/winsw)，这是一个可以将任何可执行文件配置成 Windows 服务的工具。

先创建一个目录，这里我的目录就叫 `sing-box`，然后下载 [WinSW-x64.exe](https://github.com/winsw/winsw/releases/tag/v2.12.0)，放到这个目录并将其重命名为：`winsw.exe`。然后我们创建一个 `winsw.xml`，通过这个文件对 sing-box 进行配置。注意！这两个文件的名字一定要相同，否则 WinSW 将无法读取到配置文件。

然后编辑 winsw.xml，写入以下内容：
```
<service>
  <id>sing-box</id>
  <name>sing-box</name>
  <description>This service runs sing-box continuous integration system.</description>
  <download from="https://你的订阅链接" to="%BASE%\config.json" auth="sspi" />
  <executable>C:\Users\homin\scoop\shims\sing-box.exe</executable>
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

现在使用：`./winsw.exe install` 安装服务，安装完成后系统每次重启都会自动运行 sing-box，但是现在我们先用 `./winsw.exe start` 来启动服务，你将会在当前目录下看到 `winsw.wrapper.log` 文件，这个文件包含服务启动时的日志，如果一切正常，那么日志应该是这样：

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
# 可以用start.bat 手动执行

