@REM /*
@REM  * @Author: LastOS-Pacav
@REM  * @Date: 2023-10-31 23:58:03
@REM  * @Last Modified by:   LastOS-Pacav
@REM  * @Last Modified time: 2023-10-31 23:58:03
@REM  */


@REM addtopath.cmd

@REM this will add to path files cl65, acme and x16emu script
@REM ref https://stackoverflow.com/questions/9546324/adding-a-directory-to-the-path-environment-variable-in-windows
@REM https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc755104(v=ws.10)?redirectedfrom=MSDN
@echo off
echo adding files to path
@REM set PATH=%PATH%;C:\your\path\here\
@REM echo %YOUR_ENV_VARIABLE%
acme=path
cl65=path
x16emu script=path

@REM ref https://ss64.com/nt/path.html
@REM SetX MYAPP "C:\Program Files\My App" -m

@REM setup additional paths
@REM set sc=Source.Code
@REM set path=%path%;%~dp0bin;%~dp0%sc%\Tools;%~dp0%sc%\Tools\_x86

@REM https://stackoverflow.com/questions/19287379/how-do-i-add-to-the-windows-path-variable-using-setx-having-weird-problems

@echo off
set OWNPATH=%~dp0
set PLATFORM=mswin

if defined ProgramFiles(x86)                        set PLATFORM=win64
if "%PROCESSOR_ARCHITECTURE%"=="AMD64"              set PLATFORM=win64
if exist "%OWNPATH%tex\texmf-mswin\bin\context.exe" set PLATFORM=mswin
if exist "%OWNPATH%tex\texmf-win64\bin\context.exe" set PLATFORM=win64

rem Check if the PATH was updated previously
echo %PATH% | findstr "texmf-%PLATFORM%" > nul

rem Only update the PATH if not previously updated
if ERRORLEVEL 1 (
  set Key="HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
  for /F "USEBACKQ tokens=2*" %%A in (`reg query %%Key%% /v PATH`) do (
    if not "%%~B" == "" (
      rem Preserve the existing PATH
      echo %%B > currpath.txt

      rem Update the current session
      set PATH=%PATH%;%OWNPATH%tex\texmf-%PLATFORM%\bin

      rem Persist the PATH environment variable
      setx PATH "%%B;%OWNPATH%tex\texmf-%PLATFORM%\bin" /M
    )
  )
)



@REM %%%%%%%%%%%%%%%

https://stackoverflow.com/questions/18701783/windows-equivalent-of-export

To translate your *nix style command script to windows/command batch style it would go like this:

SET PROJ_HOME=%USERPROFILE%/proj/111
SET PROJECT_BASEDIR=%PROJ_HOME%/exercises/ex1
mkdir "%PROJ_HOME%"


https://copyprogramming.com/howto/windows-equivalent-of-export#windows-command-line-alternative-for-export


@setlocal enableextensions enabledelayedexpansion
@echo off
set MinGWmsys=%CD%\tools\MinGW\msys\1.0\bin;
set lpath=%PATH%
if not "!lpath:%MinGWmsys%=!" == "%lpath%" (
echo PATH already contained %MinGWmsys%
) else (
echo Adding %MinGWmsys% to PATH
setx PATH "%MinGWmsys%;%PATH%"
)
endlocal
W
