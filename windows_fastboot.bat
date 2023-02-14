@echo off
cd %~dp0
echo.
set fastboot=bin\windows\fastboot.exe
if not exist %fastboot% echo %fastboot% not found. & pause & exit /B 1
echo Waiting for device... (Install drivers if needed)
set device=unknown
set status="false"
for /f "tokens=2" %%D in ('%fastboot% getvar product 2^>^&1 ^| findstr /l /b /c:"product:"') do set device=%%D
echo.
if "%device%" equ "secret" set status="true"
if "%device%" equ "rosemary" set status="true"
if "%device%" equ "maltose" set status="true"

if %status% neq "true" echo Compatible devices: rosemary/secret/maltose & echo Your device: %device% & echo. & echo [Missmatching image and device] & set /p=Press any key to close ... & exit /B 1

echo Your device: %device%
echo Edition: MI
echo.
echo This script will flash modified logo to this device.
echo.
%fastboot% flash logo logo.bin || @echo "Flash logo error" && pause
echo.
%fastboot% reboot
echo.
echo ##################################################################################
echo MI Logo is flashed succesfully. Follow @byMehroj on Telegram for more ...
echo ##################################################################################
echo.
set /p=Press any key to close ...
