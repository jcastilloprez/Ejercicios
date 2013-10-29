# Ejercicios del 21-10-2013

## Ejercicio 1

**Crear un espacio de nombres y montar en él una imagen ISO de un CD de forma que no se pueda leer más que desde él.**

Lo primero que tenemos que hacer para realizar el ejercicio es descargarnos una imagen ISO. En mi caso, me he descargado la ISO de Ubuntu 12.04. 

A continuación, creamos el directorio donde vamos a montar la imagen que nos acabamos de descargar. Se hace con la siguiente orden: 

`sudo mkdir -p /mnt/ej1`

Ahora creamos el espacio de nombres:

`sudo unshare -m /bin/bash`

Por último, montamos la imagen con la siguiente orden:

`mount -o loop ubuntu-12.04-desktop-i386.iso /mnt/ej1` 

Una vez que hemos montado la imagen nos desplazamos al directorio, que le hemos indicado para que monte la imagen, y vemos como nos ha montado la imagen ISO en el directorio. 

![Ejercicio 1 - Foto 1](http://ubuntuone.com/3m5ZfwNVmVUGa5kFwBdjgU)

Para comprobar que es correcto, abrimos otra terminal con un usuario diferente al que hemos tenido en el paso anterior y nos desplazamos al directorio donde se supone que está montado la imagen ISO. 

![Ejercicio 1 - Foto 2](http://ubuntuone.com/0QrJwgVSklMsXV3xj56SK4)

Y como podemos apreciar no nos deja ver el contenido ya que este solo es accesible desde el espacio de nombres creado al principio del ejercicio. 

## Ejercicio 2

**1. Mostrar los puentes configurados en el sistema operativo.**

Lo primero de todo es instalar el siguiente paquete:

`sudo apt-get install bridge-utils`

A continuación introducimos la siguiente orden y nos dirá los puentes que tiene configurado mi sistema operativo:

`brctl show`

Y como podemos apreciar en la siguiente captura de pantalla, mi sistema operativo no tiene configurado ningún puente.

![Ejercicio 2 - Foto 1](http://ubuntuone.com/4gP3Ivq5G25KuWItpdliQV)

**2. Crear un interfaz virtual y asignarlo al interfaz de la tarjeta wifi, si se tiene, o del fijo, si no se tiene.**

Empezamos creando el puente con la siguiente orden: 
 
`sudo brctl addbr ej2`

A continuación, el puente que acabamos de crear lo asignamos a la tarjeta fija:

`sudo brctl addif ej2 eth0`

y mostramos todas las interfaces que tenemos, viendo la que acabamos de crear, así como los puentes que tenemos configurados: 

![Ejercicio 2 - Foto 2](http://ubuntuone.com/2TV1GwXKhaNzckXM3b6fDY)

# Ejercicios del 25-10-2013

## Ejercicio 3

**1. Usar debootstrap (o herramienta similar en otra distro) para crear un sistema mínimo que se pueda ejecutar más adelante.**

Lo primero que tenemos que hacer es instalar debootstrap:

`sudo apt-get install debootstrap`

A continuación instalamos la versión quantal, tal y como viene en los apuntes de la asignatura: 

`sudo debootstrap --arch=i386 quantal /home/jaulas/quantal http://archive.ubuntu.com/ubuntu`

y al cabo de unos minutos ya tendremos instalada la versión mínima de ubuntu. 

Para probar que de verdad tenemos el sistema mínimo montado, utilizando la orden chroot podemos cambiar al root del sistema que acabamos de montar y ver que está completo.

![Ejercicio 3 - Foto 1](http://ubuntuone.com/2QlYO7cvnr0NOAWamVMLiT)

**2. Experimentar con la creación de un sistema Fedora dentro de Debian usando Rinse.**

Lo primero que tenemos que hacer es instalar rinse:

`sudo apt-get install rinse`

Una vez que lo tenemos instalado podemos visualizar las distintas distribuciones que tiene y pueden ser instaladas.

![Ejercicio 3 - Foto 2](http://ubuntuone.com/7FxQvkapA7UnQlru2TzZwx)

A continuación, vamos a instalar la versión de fedora-core-10 utilizando rinse, con la siguiente orden: 

`sudo rinse --arch i386 --distribution fedora-core-10 --directory /home/jaulas/fedora` 

Una vez terminada la instalación, con chroot podemos acceder como root al sistema que acabamos de instalar y ver que está completo.

![Ejercicio 3 - Foto 3](http://ubuntuone.com/5MhSoYYlcppW86X5aFLAxK)

## Ejercicio 4

**Instalar alguna sistema debianita y configurarlo para su uso. Trabajando desde terminal, probar a ejecutar alguna aplicación o instalar las herramientas necesarias para compilar una y ejecutarla.**

El sistema debianita que voy a utilizar es el que hemos instalado en el ejercicio anterior. La aplicación que voy a usar está hecha con python 3 y por lo tanto tenemos que acceder a la máquina con chroot e instalar los paquete necesarios para su ejecución. 

Abrimos un editor de textos por consola, como nano, y escribimos en él el fichero python con nuestra aplicación. En mi caso, el pequeño programa que he realizado es intentar adivinar el número que ha pensado el programa.

![Ejercicio 4 - Foto 1](http://ubuntuone.com/1r39hT7mledaV9RFpSjLcf)

Y un ejemplo de su ejecución se muestra a continuación:

![Ejercicio 4 - Foto 2](http://ubuntuone.com/3icZUUsNdFSg66ERbYP4Nl)
