#!/usr/bin/python3
#------------------------------------------------------
# Jesus HERNANDEZ
# 19.1.2023
# Simplificado del codigo original
# - Anyadido un ANSI escape para poner el texto a normal (faltaba)
# - Lectura de parametros simplificada
# - Libreria de parsing de argumentos eliminada + main class fuera
# - Todo lo demas igual que el original
# Uso desde la consola una vez compilado (ejemplo):
# mipx2ansi.exe fotito1.png
# ... que genera un fichero llamado fotito1.png.ans
# ... y se puede visualizar mediante:
# type fotito1.png.ans
#------------------------------------------------------
# Px2ANSI: Pixel Art to ANSI Art conversions
# Author: Nell Fauveau
# https://github.com/Nellousan/px2ansi
#
# Copyright 2022 Nell Fauveau
#
# Px2ANSI is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation.
#
# Px2ANSI is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

from PIL import Image
import numpy as np

#import argparse

import sys  #simplemente para leer el argumento

# HA SIDO NECESARIO MODIFICAR ESTO para usar la pagina de codigos 850
# que es el estandar en las consolas de Windows (i.e. CMD)
# ▀ es chr(223)
# ▄ es chr(220)
def pixels_to_ansi(px1: np.array, px2: np.array) -> str:
    res = ""
    if px1[3] != 255 or px2[3] != 255:
        res += "\033[0m"
    if px1[3] != 255 and px2[3] != 255:
        res += " "
    if px1[3] == 255:
        res += "\033[38;2;{};{};{}m".format(px1[0], px1[1], px1[2])
        if px2[3] == 255:
            res += "\033[48;2;{};{};{}m".format(px2[0], px2[1], px2[2])
        res += chr(223)
        #res += "▀"
    elif px2[3] == 255:
        res += "\033[38;2;{};{};{}m".format(px2[0], px2[1], px2[2])
        res += chr(220)
        #res += "▄"
    return res


def image_to_ansi(array: np.ndarray) -> str:
    final_res = ""

    for i in range(int(array.shape[0] / 2)):
        for j in range(array.shape[1]):
            final_res += pixels_to_ansi(array[i * 2][j], array[i * 2 + 1][j])
        final_res += "\033[0m\n"
    if int(array.shape[0]) % 2 != 0:
        for j in range(array.shape[1]):
            final_res += pixels_to_ansi(
                array[array.shape[0] - 1][j],
                np.zeros((4))
            )

    return final_res


# Simplificado sin usar argumentos raros
def load_image(filename) -> np.ndarray:
    image = Image.open(filename)
    image = image.convert("RGBA")
    array = np.array(image)
    return array


#---------------------------------------------------------
# MAIN
#---------------------------------------------------------

filename = ""
filenameANS = ""

if ( len(sys.argv)==1 ):
    print("Falta pasar como argumento el nombre de la imagen a convertir PNG/JPG")
    print("Saliendo...")
    exit(1)
elif ( len(sys.argv)==2 ):
    filename=sys.argv[1]  #el primer parametro
    filenameANS = filename + ".ans"
else:
    print("Demasiados parametros, solo 1 parametro con el nombre de la imagen")
    print("Saliendo...")
    exit(1)


try:
    array = load_image(filename)
except:
    print("ERROR, hubo un problema al procesar la imagen", filename)
    print("Saliendo...")
    exit(1)

try:
    final_res = image_to_ansi(array)
    final_res=final_res + "\033[0m" + "\n"
    #print("Tamanyo total de final_res...", len(final_res))
except:
    print("ERROR, hubo un problema al procesar la imagen")
    print("Saliendo...")
    exit(1)
    
try:
    f=open(filenameANS, "w")
    f.write(final_res)
    f.close()
except:
    print("ERROR, hubo un problema al generar el fichero", filenameANS)
    print("Saliendo...")
    exit(1)

print("Imagen", filename, "procesada. Fichero ANSI", filenameANS, "generado con exito.")

