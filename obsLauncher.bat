@echo off

setlocal enabledelayedexpansion



rem Local Variables
set "recordFolder=C:\test"
set "obsFolder=C:\Program Files\obs-studio\bin\64bit"
set "max_files=10"
set "file_older="
set "date_older="
set "counter=1"

cd %recordFolder%

rem We count the number of files that exist in the folder to know if we have to remove the older
for %%i in (*) do (
    set /a "counter+=1"
)

echo Number of files: !counter!

rem We remove only the older file modified when is more than 10 files (defined in local variables)
if !counter! gtr !max_files! (

    for %%i in (*) do (
        set "main_file=%%i"
        
        rem We get the date of the last file modification, we use this parsing technic  because it doesn't work how to get directly using 'dir' command.
        set "main_date="
        for /f "tokens=1-3 delims= " %%j in ('dir /tw "%%i" ^| findstr /b "^[0-9]"') do (
            set "dia=%%j"
            set "mes=%%k"
            set "anio=%%l"
            set "main_date=!dia!!mes!!anio!"
        )

        if not defined date_older (
            set "date_older=!main_date!"
            set "file_older=!main_file!"
            rem echo [DEBUG]  !counter! Saved the first date: !main_file! - Fecha: !main_date!
        )else (
            if !main_date! lss !date_older! (
                
                echo Removing the older file !main_file! - Fecha: !main_date!
            )
            set "date_older=!main_date!"
            set "file_older=!main_file!"
            rem echo [DEBUG] New file !main_file! - Fecha: !main_date!
        )
        rem echo [DEBUG]  !counter! Archivo: !main_file! - Fecha: !main_date!
    )

echo Borrando... !file_older! - Fecha: !date_older!
del !main_file!
)

rem We start OBS Studio minimizing to background
cd %obsFolder%

start obs64.exe --startrecording

timeout /t 5 /nobreak > nul
nircmd win hide process obs64.exe

rem We start the final program that we would like to execute
start "" "C:\Program Files\Notepad++\notepad++.exe"


endlocal