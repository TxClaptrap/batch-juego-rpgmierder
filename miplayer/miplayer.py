# Jesus HERNANDEZ
# 18.1.2023
# Copiado de un foro sobre el tema en stackoverflow.com
# ...y adaptado para leer los parámetros
# https://stackoverflow.com/questions/7746263/how-can-i-play-an-mp3-with-pygame

import pygame
import sys

print(sys.argv)

if (len(sys.argv)==1):
    print("Falta pasar fichero de musica MP3/MOD/MID/etc... como unico argumento")
    print("Saliendo")
    exit(1)
elif (len(sys.argv)==2):
    file=sys.argv[1]  #primer argumento al llamar al script
else:
    pass
    

#file = 'drmario.mp3'
#file= "Lands_54.mid"  #Yvel city from LOL
pygame.init()
pygame.mixer.init()
try:
    pygame.mixer.music.load(file)
except:
    print("Problema con el fichero", file, "Saliendo...")
    exit(1)

pygame.mixer.music.play()
while pygame.mixer.music.get_busy(): 
    pygame.time.Clock().tick(10)

print("Script acabado...")
pygame.quit()
exit()



