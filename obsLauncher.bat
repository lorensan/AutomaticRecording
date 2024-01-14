@echo off

setlocal enabledelayedexpansion



rem Variables Locales
set "recordFolder=C:\test"
set "obsFolder=C:\Program Files\obs-studio\bin\64bit"
set "max_archivos=10"
set "archivo_mas_antiguo="
set "fecha_mas_antigua="
set "counter=1"

cd %recordFolder%

rem Contamos el número de archivos que hay en la carpeta para saber si tenemos que borrar
for %%i in (*) do (
    set /a "counter+=1"
)

echo Numero de archivos: !counter!

rem Solo borramos el más antiguo si el numero de archivos es mayor a 10
if !counter! gtr !max_archivos! (

    for %%i in (*) do (
        set "archivo_actual=%%i"
        
        rem Obtener la fecha de última modificación del archivo, usamos esta forma de parseo por que no funciona obtenerla directamente con 'dir'
        set "fecha_actual="
        for /f "tokens=1-3 delims= " %%j in ('dir /tw "%%i" ^| findstr /b "^[0-9]"') do (
            set "dia=%%j"
            set "mes=%%k"
            set "anio=%%l"
            set "fecha_actual=!dia!!mes!!anio!"
        )

        if not defined fecha_mas_antigua (
            set "fecha_mas_antigua=!fecha_actual!"
            set "archivo_mas_antiguo=!archivo_actual!"
            rem echo !counter! Guardada la primera fecha: !archivo_actual! - Fecha: !fecha_actual!
        )else (
            if !fecha_actual! lss !fecha_mas_antigua! (
                
                echo Borrando el mas antiguo !archivo_actual! - Fecha: !fecha_actual!
            )
            set "fecha_mas_antigua=!fecha_actual!"
            set "archivo_mas_antiguo=!archivo_actual!"
            rem echo Nuevo Archivo !archivo_actual! - Fecha: !fecha_actual!
            
        )
        rem echo !counter! Archivo: !archivo_actual! - Fecha: !fecha_actual!
    )

echo Borrando... !archivo_mas_antiguo! - Fecha: !fecha_mas_antigua!
rem del !archivo_actual!
)

rem Iniciamos OBS Studio minimizado en la barra de tareas

cd %obsFolder%

start obs64.exe --startrecording

timeout /t 5 /nobreak > nul
nircmd win hide process obs64.exe

:: start "" "C:\Program Files\Notepad++\notepad++.exe"


endlocal