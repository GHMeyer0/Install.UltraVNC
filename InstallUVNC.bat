@echo off

REM Servidor onde se encontra os instaladores do VNC
set ServidorDeploy=\\Excelenciajoi.local\netlogon\UltraVNC\

REM Verificar se o vnc esta instalado

if exist "C:\Program Files\UltraVNC" GOTO END

if not exist "C:\Program Files\UltraVNC" (
  mkdir "C:\Program Files\UltraVNC"
)

REM *********************************

copy /Y "%ServidorDeploy%SCHook.dll" "C:\Program Files\UltraVNC\SCHook.dll"
copy /Y "%ServidorDeploy%SCHook64.dll" "C:\Program Files\UltraVNC\SCHook64.dll"
copy /Y "%ServidorDeploy%acl.txt" "C:\Program Files\UltraVNC\acl.txt"

if not "%ProgramFiles(x86)%"=="" (goto x64) else (goto x86)

:x64
  start /wait %ServidorDeploy%UltraVNC_X64_Setup.exe /verysilent /loadinf=%ServidorDeploy%vncserver.inf /norestart
  goto fim

:x86
  start /wait %ServidorDeploy%UltraVNC_X86_Setup.exe /verysilent /loadinf=%ServidorDeploy%vncserver.inf /norestart
  goto fim

:END
  copy /Y "%ServidorDeploy%ultravnc.ini" "C:\Program Files\UltraVNC\ultravnc.ini"
  "C:\Program Files\UltraVNC\MSLogonACL.exe" /i /o "C:\Program Files\UltraVNC\acl.txt"
  net stop uvnc_service
  net start uvnc_service
  if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\UltraVNC\" (
    rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\UltraVNC\"
  )
  
  exit