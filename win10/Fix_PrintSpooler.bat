@Echo off
Color A
Title Fix Print spooler

rem 替换win32spl.dll
rem 重启打印服务


Echo --------------------------------------------------------------------------
Echo 停止打印服务
net stop spooler
Echo --------------------------------------------------------------------------
Echo 替换 win32spl.dll
rem win32spl.dll
Echo --------------------------------------------------------------------------
timeout /t 3 /nobreak
Takeown /A /F C:\Windows\System32\win32spl.dll
icacls  "C:\Windows\System32\win32spl.dll" /grant "administrators":F
icacls  "C:\Windows\System32\win32spl.dll" /grant SYSTEM:F
ren  C:\Windows\System32\win32spl.dll win32spl.dll.old
copy  "%~dp0\win32spl.dll" C:\Windows\System32\win32spl.dll /Y

Echo --------------------------------------------------------------------------
Echo 增加注册表 RpcAuthnLevelPrivacyEnabled = 0
Echo --------------------------------------------------------------------------

rem add regkey
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f

Echo --------------------------------------------------------------------------
Echo 启动打印服务
net start spooler
Echo --------------------------------------------------------------------------
Echo 完成操作，请进行打印测试吧！
pause