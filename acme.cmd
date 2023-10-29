@REM acme.cmd file
@REM checks for the existance of acme portable ppapp
@echo off
cls
color 0a
@REM this sets the acme crosscompiler variable
:SetAcme  variable
@REM set acme="%ProgramFiles%\acme\acme.exe"
@REM if exist "%ProgramFiles(x86)%\acme\acme.exe" set acme="%ProgramFiles(x86)%\acme\acme.exe"
FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO IF EXIST "%%i:\ppApps\acme\acme.exe" (SET acme="%%i:\ppApps\acme\acme.exe"& goto doitnow)

:doitnow
echo.
echo acme = %acme%
echo.