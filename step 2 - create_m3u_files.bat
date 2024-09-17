@echo off
setlocal enabledelayedexpansion
for /f "delims=" %%f in ('dir /b /ad') do (
  echo Listing files and folders in %%f...
  if exist "%%f.m3u" del "%%f.m3u"
  (
    for /f "delims=" %%i in ('dir /b /a-d "%%f\*.cue"') do (
      set "output=%%f/%%i"
      echo !output!>> "%%f.m3u"
    )
  )
  echo Output saved to %%f.m3u.
  echo.
)