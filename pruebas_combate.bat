@echo off
setlocal EnableDelayedExpansion
chcp 65001>nul
rem VIDA DE PERSONAJES
set /a "vidaPersonaje=10"
set /a "vidaEnemigo=5"

type texto\combate\inicio.txt

:combate
echo.
echo Zurullenstein: !vidaPersonaje! ^| Excrementoso: !vidaEnemigo!
echo.
type texto\combate\ataques.txt
echo.

set /a "aciertoJugador=!random! %% 4"
set /p "opcion=Elige tu ataque (1-3): "
echo.

rem ATAQUE DE ZURULLENSTEIN
if !opcion! equ 1 (
    set /a "vidaEnemigo-=1"
    echo Le has conseguido cercenar un pedacito de caca a tu enemigo.
) else if !opcion! equ 2 (
    if !aciertoJugador! lss 3 (
        set /a "vidaEnemigo-=2"
        type texto\combate\tirachinasAcierto.txt
    ) else (
        echo Tu china laxante falló...
    )
) else if !opcion! equ 3 (
    if !aciertoJugador! lss 2 (
        set /a "vidaEnemigo-=5"
        set /a "vidaPersonaje-=2"
        type texto\combate\granadaAcierto.txt
    ) else (
        type texto\combate\granadaFallo.txt
    )
) else if !opcion! equ 4 (
    echo Lo has intentado, pero tu sexapeal mierder no surge efecto en el excrementoso...
) else (
    type texto\combate\errorEleccion.txt
    goto combate
) 
rem COMPROBACIÓN DE VIDA
if !vidaEnemigo! leq 0 (
    type texto\combate\victoria.txt
    goto finCombate
)  else (
    goto :ataqueEnemigo
)

rem ATAQUE DEL LACAYO EXCREMENTOSO
set /a "ataqueEnemigo=!random! %% 4"
set /a "factorAleatorio=!random! %% 4"
:ataqueEnemigo
echo. 
echo Es el turno del excremento:
echo.
if !ataqueEnemigo! leq 1 (
    if !factorAleatorio! lss 3 (
        set /a "vidaPersonaje-=1"
        echo Tu enemigo te acaba de lanzar... ¿Te acaba de estampar una bola de mierda en la cara?
    ) else (
        echo El enemigo intentó alcanzarte con un proyectil marrón, pero falló.
    )
) else (
    if !factorAleatorio! lss 2 (
        set /a "vidaPersonaje-=2"
        type texto\combate\abrazo.txt
    ) else (
        echo El enemigo intentó abrazarte, pero gracias a tu destreza con las cacavorteretas, lo has podido eludir.
    )
) 
rem COMPROBACIÓN DE VIDA
if !vidaPersonaje! leq 0 (
    type texto\combate\derrota.txt
    goto finCombate
) else (
    goto combate
)

:finCombate
echo Fin del combate.
pause
