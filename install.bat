@echo off
@setlocal enableextensions
@cd /d "%~dp0"

REM script by un4

set MVC=mvn
set LIBPATHZ=[your lib]
set GRID=[your groupid]
set ARTID=[your artifectid]
set LIBVER=[your version]

set INFOV=[+] Dependency info : GroupId=%GRID%, ArtifactId=%ARTID%, Version=%LIBVER%

echo ============================================
echo		EC02 DEPENDENCY INSTALLER 
echo ============================================
call %MVC% -version > nul 2>&1
if %ERRORLEVEL% neq 0 color 0c && echo.[-] **%MVC% NOT FOUND, please check your MAVEN configuration** && goto execErrorExit
echo ============================================
echo %INFOV%
echo ============================================
call java -version
echo ============================================
call %MVC% -version
echo ============================================
call %MVC% install:install-file -Dfile=%LIBPATHZ% -DgroupId=%GRID% -DartifactId=%ARTID% -Dversion=%LIBVER% -Dpackaging=jar -DgeneratePom=true

echo ============================================
echo [+] check your POM.xml, if it not contain this dependency, add below config to your POM.xml
echo ============================================

echo ^<dependency^>
echo	^<groupId^>%GRID%^</groupId^>
echo	^<artifactId^>%ARTID%^</artifactId^>
echo	^<version^>%LIBVER%^</version^>
echo ^</dependency^>

:execErrorExit
echo ============================================
pause
exit /b 1


