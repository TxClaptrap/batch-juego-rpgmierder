@echo off
start "mimusica1" /MIN miplayer.exe .\music\introlarga.mp3
setlocal enableDelayedExpansion

chcp 65001
cls
rem RPG MIERDER

set COLORNORMAL=[0m

set COLORROSA=[38;2;255;182;193m
set COLORAZULCIELO=[38;2;135;206;250m
set COLORMARRON=[38;2;139;69;19m
set COLORNARANJA=[38;2;255;165;0m
set COLORAMARILLO=[38;2;255;255;0m
set COLORROJO=[38;2;255;0;0m
set COLORVIOLETA=[38;2;255;0;255m
color 0A
set PARPADEANTE=[5m
set COLORINVERSO=[7m

:intro
echo %COLORMARRON%%PARPADEANTE%
type .\ansi\00titulo.ans
echo %COLORNORMAL%
echo.
type .\texto\01intro.txt

:preguntaIntro
echo %COLORROSA%%PARPADEANTE%SI%COLORNORMAL%
echo %COLORROJO%NO%COLORNORMAL%
echo.
set /p opcion=¿Qué me dices?:

if /i !opcion!==SI (
    goto :inicio
) else if /i !opcion!==NO (
    echo.
    echo ¿Estás completamente seguro de que te lo quieres perder?
    echo.
    echo %COLORROSA%%PARPADEANTE%NO%COLORNORMAL%
    echo %COLORROJO%SI%COLORNORMAL%
    set /p opcion=Escribe tu elección:
    echo.
    goto :preguntaIncorrecta
) else (
    echo.
    type texto\combate\errorEleccion.txt
    goto :preguntaIntro
)

:preguntaIncorrecta
if /i !opcion!==SI (
    :respuestaInvalida
    echo Estoy seguro que te vas a arrepentir, venga, ¿empezamos verdad?
    goto :preguntaIntro
) else if /i !opcion!==NO (
    goto :inicio
) else (
    echo.
    type texto\combate\errorEleccion.txt
    goto :respuestaInvalida
)

rem PRIMERA INTERACCIÓN EN LA AVENTURA
:inicio
cls
chcp 850>nul
echo _______________________________________________________________________________
type .\ansi\01caca_feliz.png.ans
echo _______________________________________________________________________________
chcp 65001>nul
echo. 
type .\texto\02inicio.txt
echo %COLORAMARILLO%%PARPADEANTE%"PARTIR"%COLORNORMAL%: No hay tiempo que perder, recoges tu fiel Espada Desodorante, tu tirachinas con munición laxante, las granadas de moscas y tu rollo de papel higiénico (nunca se sabe) para partir inmediatamente.
<nul set /p =%COLORROJO%"CHILL"%COLORNORMAL%: & type texto\accion1\chill.txt
echo.
<nul set /p =%COLORROJO%"TRUÑIFLECHA"%COLORNORMAL%: & type texto\accion1\truniflecha.txt
echo.
echo.
:preguntaInicio
set /p opcion=¿Qué decides?:
if /i !opcion!==PARTIR (
    goto :partir
) else if /i !opcion!==CHILL (
    cls
    goto :cacaPota
    :chill
    echo.
    type .\texto\chill.txt
    echo.
    goto :salir
) else if /i !opcion!==TRUÑIFLECHA (
    cls
    goto :cacaGafas
    :truniflecha
    echo.
    type .\texto\truniflecha.txt
    echo.
    goto :salir
) else (
    echo.
    type texto\combate\errorEleccion.txt
    goto :preguntaInicio
)

rem SEGUNDA INTERACCIÓN EN LA AVENTURA
:partir
cls
chcp 850>nul
echo _______________________________________________________________________________
type .\ansi\cacaespada.png.ans
echo _______________________________________________________________________________
chcp 65001>nul
echo.
type .\texto\partir.txt
:preguntaPartir
echo %COLORROJO%"ATAJO"%COLORNORMAL%: Atajo de las Flatulencias
echo %COLORNARANJA%%PARPADEANTE%"RUTA"%COLORNORMAL%: Ruta de los Retortijones
echo %COLORROJO%"PAUSA"%COLORNORMAL%: Hacer una pausa para revisar el mapa
echo.
set /p opcion=¿Qué decides?:
echo.
if /i !opcion!==ATAJO (
    cls
    goto :reyMosca
    :atajo
    echo.
    type texto\atajo.txt
    echo.
    goto :salir
) else if /i !opcion!==PAUSA (
    cls
    goto :cacaGafas2
    :pausa
    echo.
    type .\texto\pausa.txt
    echo.
    goto :salir
) else if /i !opcion!==RUTA (
    taskkill /IM "miplayer.exe" /F  >NUL 2>NUL
    start "mimusica1" /MIN miplayer.exe .\music\batalla1.mp3
    cls

    rem TERCERA INTERACCIÓN: BATALLA

    type .\texto\ruta.txt
    rem Vida de los personajes
    set /a "vidaPersonaje=10"
    set /a "vidaEnemigo=5"
    echo.
    type .\texto\combate\inicio.txt
    echo.
    echo %COLORNARANJA%Presiona cualquier tecla para empezar la pelea...%COLORNORMAL%
    pause > nul
    :combate
    cls
    goto :cacaEnfadada
    :vueltaCombate
    echo.
    echo Zurullenstein: !vidaPersonaje! HP ^| Excrementoso: !vidaEnemigo! HP
    echo %COLORAMARILLO%
    type texto\combate\ataques.txt
    echo %COLORNORMAL%

    set /a "aciertoJugador=!random! %% 4"
    set /p "opcion=Elige tu ataque (1-3): "

    rem Ataques de Zurullenstein
    if !opcion! equ 1 (
        set /a "vidaEnemigo-=1"
        echo.
        echo Le has conseguido cercenar un pedacito de caca a tu enemigo.
    ) else if !opcion! equ 2 (
        if !aciertoJugador! lss 3 (
            set /a "vidaEnemigo-=2"
            echo.
            type texto\combate\tirachinasAcierto.txt
            echo.
        ) else (
            echo.
            echo Tu china laxante falló...
        )
    ) else if !opcion! equ 3 (
        if !aciertoJugador! lss 2 (
            set /a "vidaEnemigo-=5"
            set /a "vidaPersonaje-=2"
            echo.
            type texto\combate\granadaAcierto.txt
        ) else (
            echo.
            type texto\combate\granadaFallo.txt
        )
    ) else if !opcion! equ 4 (
        echo.
        echo Lo has intentado, pero tu sexapeal mierder no surge efecto en el excrementoso...
    ) else (
        echo.
        type texto\combate\errorEleccion.txt
        echo %COLORAZULCIELO%Presiona cualquier tecla para continuar la batalla...%COLORNORMAL%
        pause > nul
        goto :combate
    ) 
    rem Comprobación de vida del enemigo
    if !vidaEnemigo! leq 0 (
        echo.
        type texto\combate\victoria.txt
        echo.
        goto :finCombate
    )  else (
        goto :ataqueEnemigo
    )

    rem Ataque del Lacayo Excrementoso
    :ataqueEnemigo
    set /a "ataqueEnemigo=!random! %% 4"
    set /a "factorAleatorio=!random! %% 4"
    echo. 
    echo Es el turno del enemigo:
    if !ataqueEnemigo! lss 2 (
        if !factorAleatorio! lss 3 (
            set /a "vidaPersonaje-=1"
            echo.
            echo Tu enemigo te acaba de lanzar... ¿Te acaba de estampar una bola de mierda en la cara?
        ) else (
            echo.
            echo El enemigo intentó alcanzarte con un proyectil marrón, pero falló.
        )
    ) else (
        if !factorAleatorio! lss 2 (
            set /a "vidaPersonaje-=2"
            echo.
            type texto\combate\abrazo.txt
            echo.
        ) else (
            echo.
            echo El enemigo intentó abrazarte, pero gracias a tu destreza con las cacavorteretas, lo has podido eludir.

        )
    ) 
    rem Comprobación de vida de Zurullenstein
    if !vidaPersonaje! leq 0 (
        echo.
        type texto\combate\derrota.txt
        echo.
        pause > nul
        goto :salir
    ) else (
        echo.
        echo %COLORAZULCIELO%Presiona cualquier tecla para continuar la batalla...%COLORNORMAL%
        pause > nul
        goto :combate
    )
    :finCombate
    echo.
    echo %COLORAZULCIELO%Presiona cualquier tecla para continuar...%COLORNORMAL%
    pause > nul
    echo.
    cls
    goto :imgFinal
    :vueltaFinal
    echo %COLORVIOLETA%%PARPADEANTE%¿Te ha gustado RPG Mierder? La aventura continuará en... %COLORMARRON%RPG Mierder: La Furia de Don Mojón... %COLORNORMAL%No es verdad, pero es que meter más código en este lenguaje es una tortura.
    goto :salir

) else (
    type texto\combate\errorEleccion.txt
    echo %COLORAZULCIELO%Presiona cualquier tecla para continuar...%COLORNORMAL%
    pause > nul
    goto :preguntaPartir
)


:salir
echo.
echo %COLORAZULCIELO%%COLORINVERSO%Presiona cualquier tecla para salir...
pause > nul
taskkill /IM "miplayer.exe" /F  >NUL 2>NUL
exit

:cacaEnfadada
chcp 850>nul
echo _________________________________________________________________________________________
type .\ansi\cacaenfada.png.ans
echo _________________________________________________________________________________________
chcp 65001>nul
goto :vueltaCombate

:cacaPota
chcp 850>nul
echo _______________________________________________________________________________
type .\ansi\caca_pota.png.ans
echo _______________________________________________________________________________
chcp 65001>nul
goto :chill

:cacaGafas
chcp 850>nul
echo _______________________________________________________________________________
type .\ansi\caca_gafas.png.ans
echo _______________________________________________________________________________
chcp 65001>nul
goto :truniflecha

:reyMosca
chcp 850>nul
echo _______________________________________________________________________________
type .\ansi\reymosca.png.ans
echo _______________________________________________________________________________
chcp 65001>nul
goto :atajo

:cacaGafas2
chcp 850>nul
echo _______________________________________________________________________________
type .\ansi\caca_gafas.png.ans
echo _______________________________________________________________________________
chcp 65001>nul
goto :pausa

:imgFinal
chcp 850>nul
echo _________________________________________________________________________________________
type .\ansi\donmojon.png.ans
echo _________________________________________________________________________________________
chcp 65001>nul
goto :vueltaFinal