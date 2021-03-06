:user_configuration

:: About AIR application packaging
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959
:: http://livedocs.adobe.com/flex/3/html/distributing_apps_4.html#1037515

:: NOTICE: all paths are relative to project root

:: Android packaging
set AND_CERT_NAME="RainAvgEngine"
set AND_CERT_PASS=fd
set AND_CERT_FILE=cert\RainAvgEngine.p12
set AND_ICONS=icons/android

set AND_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%AND_CERT_FILE%" -storepass %AND_CERT_PASS%

:: iOS packaging
set IOS_DEV_CERT_FILE=cert\rainDev.p12
set IOS_DIST_CERT_FILE=cert\rainDis.p12
set IOS_DEV_CERT_PASS=123456
set IOS_DIST_CERT_PASS=123456
set IOS_DEV_PROVISION=cert\StarDev.mobileprovision
set IOS_DIST_PROVISION=cert\StarDis.mobileprovision
set IOS_ICONS=icons\

set IOS_DEV_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DEV_CERT_FILE%" -storepass %IOS_DEV_CERT_PASS% -provisioning-profile %IOS_DEV_PROVISION%
set IOS_DIST_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DIST_CERT_FILE%" -storepass %IOS_DIST_CERT_PASS% -provisioning-profile %IOS_DIST_PROVISION%

:: Application descriptor
set APP_XML=application.xml
set APP_PACKAGE_XML=%APP_XML%


:: Files to package
set APP_DIR=bin
set EXT_DIR=lib
set EXT_FOLDER_DIR=ext-folder
set FILE_OR_DIR=-C %APP_DIR% .

:: Your application ID (must match <id> of Application descriptor)
for /f "tokens=2 delims=>" %%i in ('findstr "<id>" %APP_PACKAGE_XML%') do (
	for /f "delims=<" %%i in ("%%i")do (
		set APP_ID=%%i
	)
)

:: Version
for /f "tokens=2 delims=>" %%i in ('findstr "<versionNumber>" %APP_PACKAGE_XML%') do (
	for /f "delims=<" %%i in ("%%i")do (
		set VERSION=%%i
	)
)

:: Output packages
set DIST_PATH=bin-release
set DIST_NAME=RainAvgEngine

:: Debugging using a custom IP
for /f "tokens=2 delims=:" %%i in ('ipconfig^|findstr "IPv4"') do (
      for /f "delims=" %%i in ("%%i") do (
	  set DEBUG_IP=%%i
	  goto end
	  )
)

:validation
%SystemRoot%\System32\find /C "<id>%APP_ID%</id>" "%APP_PACKAGE_XML%" > NUL
if errorlevel 1 goto badid
goto end

:badid
echo.
echo ERROR: 
echo   Application ID in 'bat\SetupApplication.bat' (APP_ID) 
echo   does NOT match Application descriptor '%APP_PACKAGE_XML%' (id)
echo.

:end