@echo off
setlocal

:: Set the source directories for Chrome and Firefox data
:set "chromeProfileDir=%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default"
:set "firefoxProfileDir=%APPDATA%\Mozilla\Firefox\Profiles"

:: Set the destination directories for Chrome and Firefox data
:set "chromeDestDir=%CD%\ChromeData"
:set "firefoxDestDir=%CD%\FirefoxData"

:: Set the source directory for current user's downloads, videos, pictures, documents, and desktop
set "downloadsDir=%USERPROFILE%\Downloads"
set "videosDir=%USERPROFILE%\Videos"
set "picturesDir=%USERPROFILE%\Pictures"
set "documentsDir=%USERPROFILE%\Documents"
set "downloadsDir=%USERPROFILE%\Downloads"
set "desktopDir=%USERPROFILE%\Desktop"

:: Set the destination directories for videos, pictures, documents, and desktop
set "videosDestDir=%CD%\UserVideos"
set "picturesDestDir=%CD%\UserPictures"
set "documentsDestDir=%CD%\UserDocuments"
set "downloadsDestDir=%CD%\UserDownloads"
set "desktopDestDir=%CD%\UserDesktop"

:: Create destination directories if they don't exist
:if not exist "%chromeDestDir%" mkdir "%chromeDestDir%"
:if not exist "%firefoxDestDir%" mkdir "%firefoxDestDir%"
if not exist "%videosDestDir%" mkdir "%videosDestDir%"
if not exist "%picturesDestDir%" mkdir "%picturesDestDir%"
if not exist "%documentsDestDir%" mkdir "%documentsDestDir%"
if not exist "%desktopDestDir%" mkdir "%desktopDestDir%"
if not exist "%downloadsDestDir%" mkdir "%downloadsDestDir%"
:: Copy Chrome data to destination directory
: xcopy /E /I /Y "%chromeProfileDir%" "%chromeDestDir%"

:: Copy Firefox data to destination directory (only works if there's a single profile)
:for /D %%D in ("%firefoxProfileDir%\*") do (
:    xcopy /E /I /Y "%%~D" "%firefoxDestDir%\%%~nxD"
:    goto :EndLoop
:)
:EndLoop

:: Copy user's downloads, videos, pictures, documents, and desktop to destination directories
xcopy /E /I /Y "%downloadsDir%" "%downloadsDestDir%"
xcopy /E /I /Y "%videosDir%" "%videosDestDir%"
xcopy /E /I /Y "%picturesDir%" "%picturesDestDir%"
xcopy /E /I /Y "%documentsDir%" "%documentsDestDir%"
xcopy /E /I /Y "%desktopDir%" "%desktopDestDir%"
echo Data copied successfully.

:end
endlocal
