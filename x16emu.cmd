@REM x16emu.cmd file
@REM checks for the existance of x16emu portable ppapp
@echo off
cls
color 0a
@REM this sets the acme crosscompiler variable
:Setx16emu  variable
@REM set x16emu="%ProgramFiles%\x16emu\x16emu.exe"
@REM if exist "%ProgramFiles(x86)%\x16emu\x16emu.exe" set x16emu="%ProgramFiles(x86)%\x16emu\x16emu.exe"
FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO IF EXIST "%%i:\ppApps\x16emu\x16emu.exe" (SET x16emu="%%i:\ppApps\x16emu\x16emu.exe"& goto doitnow)

@REM d:\ppApps\x16emu\x16emu.exe -run -prg
:doitnow
@REM added the program to the path


echo.
echo x16emu = %x16emu%
echo.
@REM set options for command line
set "option1=-scale 1"
set "option2=-debug"
set "option3=-quality nearest"
@REM set "option4=-prg"
set "option5=-run"

echo option1 = %option1%
echo option2 = %option2%
echo option3 = %option3%
echo option4 = %option4%
echo option4 = %option5%
echo filerun =  %1

%x16emu%  %option1%
@REM  %option2% %option3% %option4% %option6% %1