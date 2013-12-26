# Ejercicios del 02-12-2013

## Ejercicio 1

**1. ¿Cómo tienes instalado tu disco duro? ¿Usas particiones? ¿Volúmenes lógicos?**

Lo primero que tenemos que hacer es instalarnos gparted y visualizar como está particionado el disco duro. Instalar 
gparted es tan fácil como poner en la consola:

`sudo apt-get install gparted`

Una vez que ha sido instalado, arrancarlo es tan sencillo como:

`sudo gparted`

La visualización de mi disco duro es la siguiente:

![Ejercicio 1](http://ubuntuone.com/1rKi4CoaBfqvRck4u4fOu5)

En ella podemos apreciar que el disco duro está totalmente particionado en 3 particiones primarias y otra de fat32. 
Volúmenes lógicos no tengo ninguno, ya que tengo instalado Windows 7 y dentro de este tengo instalado Ubuntu 12.04 en un
disco duro virtual en el disco duro físico.

Las 3 particiones primarias corresponden:

* La partición /dev/sda1: es la partición que se ha creado durante la instalación de Windows 7 y se utiliza para las 
tareas de arranque y seguridad de Windows 7.
* La partición /dev/sda2: es la partición que contiene todos los archivos de Windows 7 instalados y dentro de esta 
partición es donde se encuentra instalado Ubuntu. 
* La partición /dev/sda3: es la partición que contiene todo el software de HP que viene una vez que has comprado el 
ordenador.  

La partición /dev/sda4 corresponde a una partición pequeña que puedes utilizar para almacenar pequeños archivos y la 
utilizo para pasar pequeños archivos entre Windows y Ubuntu. 

**2. Si tienes acceso en tu escuela o facultad a un ordenador común para las prácticas, ¿qué almacenamiento físico** 
**utiliza?**

Los ordenadores que hay en la facultad, utilizan un sistema de ficheros remoto. Es decir, cada vez que algún alumno 
arranca el ordenador de la facultad, este le pide que se identifique y a continuación coge el contenido del alumno 
usando un NFS.

## Ejercicio 2

**Usar FUSE para acceder a recursos remotos como si fueran ficheros locales. Por ejemplo, sshfs para acceder a** 
**ficheros de una máquina virtual invitada o de la invitada al anfitrión.**

Para este ejercicio vamos a utilizar el contenedor de Ubuntu llamado `una-caja` y creado anteriormente en el tema 
anterior con `lxc`. Ahora instalamos tanto en el contenedor como en el sistema anfitrión el paquete `sshfs` para poder 
utilizarlo a continuación. Para ello lo instalamos con:

`sudo apt-get install sshfs` 

Antes de seguir, es importante que sepamos la dirección IP del contenedor para poder crear un fichero en él y después 
visualizarlo en el sistema anfitrión. Dicha dirección la visualizamos con el comando `ifconfig`:

![Ejercicio 2 - Foto 1](http://ubuntuone.com/1lAshZowI5GbIzz3DqkCGP)

Ahora en el contenedor, tenemos que añadir al grupo fuse el usuario con el cual nos vamos a conectar remotamente al 
contenedor. Dicho usuario se llama `ubuntu` y lo realizamos con el siguiente comando: 

`sudo usermod -a -G fuse ubuntu`

El siguiente paso es crearnos en el contenedor un directorio y dentro de dicho directorio un archivo para probar todo 
esto:

![Ejercicio 2 - Foto 2](http://ubuntuone.com/4p7ULujt85wKsPIMIOKz6y)

En el sistema anfitrión también necesitamos crear un directorio, para montar el directorio remoto creado anteriormente y
utilizarlo como si fuera local:

![Ejercicio 2 - Foto 3](http://ubuntuone.com/7GsTcSXt6lllNvvoz6U8kZ)

Una vez creado, vemos que el directorio está vacío. Vamos a llenarlo con el contenido de la carpeta que hay en el 
contenedor. Para ello tenemos que conectarnos indicando el nombre del usuario remoto, la dirección IP del contenedor, la
ruta del directorio remoto y la ruta del directorio local en el cual vamos a montar dicho recurso. Para ello utilizamos 
la siguiente orden:

`sshfs ubuntu@10.0.3.237:/home/ubuntu/prueba /home/josemanuel/pruebaRemota`

![Ejercicio 2 - Foto 4](http://ubuntuone.com/6GSbrHcHZoEQeHNjK0FzMc)

Una vez terminado, si abrimos dicha carpeta podemos ver que contiene el mismo archivo, con la misma información que 
tenía en el contenedor y el icono de que es una carpeta montada, que puede ser desmontada cuando nos apetezca, pulsando 
dicho icono:

![Ejercicio 2 - Foto 5](http://ubuntuone.com/32RQRowSZmh9j11afB85ks)
