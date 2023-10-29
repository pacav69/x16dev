@REM x16emu.cmd file
@echo off
cls
color 0a
@REM this sets the acme crosscompiler variable
:Setx16emu  variable
@REM set x16emu="%ProgramFiles%\x16emu\x16emu.exe"
@REM if exist "%ProgramFiles(x86)%\x16emu\x16emu.exe" set x16emu="%ProgramFiles(x86)%\x16emu\x16emu.exe"
FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO IF EXIST "%%i:\ppApps\x16emu\x16emu.exe" (SET x16emu="%%i:\ppApps\x16emu\x16emu.exe"& goto doitnow)

:doitnow

echo.
echo x16emu = %x16emu%
echo.
