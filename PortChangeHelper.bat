@echo off
echo == Bunny Server 2.0 PortChangeHelper ==
echo By Profess0r.
echo ***Warning: Your remote access connection will be terminated after the new port applied, Please use the new port to establish the new connection. ***
set /p c= Please Input your new RDP port (10000-20000):
if "%c%"=="" goto end
goto edit
:edit
netsh advfirewall firewall add rule name="Remote PortNumber" dir=in action=allow protocol=TCP localport="%c%"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v "PortNumber" /t REG_DWORD /d "%c%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "PortNumber" /t REG_DWORD /d "%c%" /f
echo Success
net stop TermService /y
net start TermService
pause
exit
:end
echo Failed
pause