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

# Ejercicios del 28-10-2013

## Ejercicio 5

**Instalar una jaula chroot para ejecutar el servidor web de altas prestaciones nginx.**

Para ejecutar nginx, voy a usar el sistema que hemos instalado en el ejercicio 3. Para ello accedemos al sistema con chroot:

`sudo chroot /home/jaulas/quantal`

Ahora vamos a instalar el paquete wget para poder descargarnos el paquete de nginx desde internet:

`apt-get install wget`

Una vez instalado el paquete anterior, ya podemos descargarnos nginx desde internet con la siguiente orden: 

`wget http://nginx.org/download/nginx-1.4.0.tar.gz`

Una vez descargado el paquete lo descomprimimos:

`tar xvzf nginx-1.4.0.tar.gz`

Entramos al directorio y lo configuramos, pero antes instalamos los siguientes paquetes ya que nos lo va a pedir a la hora de configurar el directorio e instalar nginx:

> ```
> apt-get install gcc 
> apt-get install libpcre3 libpcre3-dev
> apt-get install zlib1g-dev
> apt-get install make
> ./configure
> ```

una vez que pongamos todas las ordenes anteriores hacemos un make y un make install para instalar nginx:

> ```
> make
> make install
> ``` 

Ya tenemos instalado nginx en nuestra jaula, solo queda probar su funcionamiento, para ello con la ayuda de curl podemos visualizar contenido de archivos html desde consola. Pedimos que nos muestre el contenido de la página principal del servidor web que acabamos de instalar: 

![Ejercicio 5](http://ubuntuone.com/0tF0SJ7bvlGhLY7yZSK0sI)

## Ejercicio 6

**Crear una jaula y enjaular un usuario usando jailkit, que previamente se habrá tenido que instalar.**

Lo primero que tenemos que hacer es descargarnos el paquete jailkit desde su página web oficial, ya que no tiene paquetes oficiales. 

![Ejercicio 6 - Foto 1](http://ubuntuone.com/5oQS1DisRQeDLnBqcAxuxn)

Una vez descargado el paquete lo descomprimimos y lo instalamos con:

> ```
> tar -xzvf jailkit-2.16.tar.gz
> ./configure && make && sudo make install
> ```

Una vez terminado el proceso anterior, tenemos que crear el sistema de ficheros con permisos para root, tal y como viene en los apuntes de la asignatura:

> ```
> sudo mkdir -p /seguro/jaulas/dorada
> sudo chown -R root:root /seguro
> ```

Ahora vamos a crear la jaula con funcionalidades básicas de shell, editor de textos y herramientas de redes:

`sudo jk_init -v -j /seguro/jaulas/dorada jk_lsh basicshell netutils editors`

Después de haber creado la jaula, debemos crear al usuario que va a estar dentro de la jaula y encerrarlo en dicha jaula:

![Ejercicio 6 - Foto 2](http://ubuntuone.com/7XoytGtpVbN8l4Ynzi8O0m)

Finalmente, solo nos queda darle al usuario que acabamos de enjaular acceso a la shell /bin/bash, ya que este usuario solo tiene acceso a una shell de acceso limitado. Para ello debemos editar el fichero de configuración del usuario que se encuentra en: “/seguro/jaulas/dorada/etc/passwd” y cambiar jk_lsh por /bin/bash
