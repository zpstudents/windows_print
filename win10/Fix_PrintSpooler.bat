@Echo off
Color A
Title Fix Print spooler

rem �滻win32spl.dll
rem ������ӡ����


Echo --------------------------------------------------------------------------
Echo ֹͣ��ӡ����
net stop spooler
Echo --------------------------------------------------------------------------
Echo �滻 win32spl.dll
rem win32spl.dll
Echo --------------------------------------------------------------------------
timeout /t 3 /nobreak
Takeown /A /F C:\Windows\System32\win32spl.dll
icacls  "C:\Windows\System32\win32spl.dll" /grant "administrators":F
icacls  "C:\Windows\System32\win32spl.dll" /grant SYSTEM:F
ren  C:\Windows\System32\win32spl.dll win32spl.dll.old
copy  "%~dp0\win32spl.dll" C:\Windows\System32\win32spl.dll /Y

Echo --------------------------------------------------------------------------
Echo ����ע��� RpcAuthnLevelPrivacyEnabled = 0
Echo --------------------------------------------------------------------------

rem add regkey
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f

Echo --------------------------------------------------------------------------
Echo ������ӡ����
net start spooler
Echo --------------------------------------------------------------------------
Echo ��ɲ���������д�ӡ���԰ɣ�
pause