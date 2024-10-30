@echo off

rem Esto es la version con el interprete de Python
rem start "mimusica1" /MIN tocar.bat Lands_54.mid

rem Esto es con el programita de python YA COMPILADO
start "mimusica1" /MIN miplayer music\intro.mp3

echo Interrumpiendo en 5 segundos...
timeout /T 5


echo Interrumpiendo el MIDI
rem tasklist /V /FI "WindowTitle EQ mimusica1"
rem PARA CARGARSE EL PROGRAMITA DE PYTHON QUE TOCA MUSICA
rem Los >NUL 2>NUL son para que no genere ningun mensaje...
taskkill /IM "miplayer.exe" /F  >NUL 2>NUL


rem Version compacta que inicia una musica, espera 5 secs y termina
start "mimusica1" /MIN miplayer.exe drmario.mp3
timeout /T 5
taskkill /IM "miplayer.exe" /F  >NUL 2>NUL

