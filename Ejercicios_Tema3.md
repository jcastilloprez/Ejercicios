# Ejercicios del 11-11-2013

## Ejercicio 1

**Instala LXC en tu versión de Linux favorita.**

Para instalar LXC en tu ordenador solamente debemos instalar el paquete lxc con la siguiente orden: 

`sudo apt-get install lxc`

Una vez que se ha instalado el paquete podemos comprobar que podemos crear contenedores en nuestro ordenador y no vamos a tener ningún problema a la hora de su creación.
Para ello hacemos uso de la orden `lxc-checkconfig` y si nos muestra todos los campos con el valor enable, la herramienta lxc va a funcionar perfectamente en nuestro ordenador. 

![Ejercicio 1](http://ubuntuone.com/3NikvArAchSbaSnVIjPOei)

## Ejercicio 2

**Comprobar qué interfaces puente ha creado y explicarlos**

Lo primero que tenemos que realizar es crearnos un contenedor de ubuntu con la siguiente orden: 

`sudo lxc-create -t ubuntu -n una-caja`

Una vez que se ha instalado el contenedor podemos acceder a él con la siguiente orden:

`sudo lxc-start -n una-caja`

y entrar en el sistema operativo con el usuario `ubuntu` y password `ubuntu`

![Ejercicio 2 - Foto 1](http://ubuntuone.com/1KLOa7LAYSb5xPujhx6mw6)

Si listamos en qué estado están los contenedores con la orden `lxc-list` nos dice que nuestro contenedor llamado una-caja se encuentra en estado ejecutándose. 

![Ejercicio 2 - Foto 2](http://ubuntuone.com/5NalEkOYeZzkld2vPIM1n3)

A continuación, si listamos todas las interfaces que tenemos en nuestro ordenador con la orden `ip addr show` 
podemos apreciar como se nos ha creado dos nuevas interfaces que corresponden al contenedor creado anteriormente. 

![Ejercicio 2 - Foto 3](http://ubuntuone.com/2q4CwnfKgO8XUNx1zOeIiX)

Y si listamos los puentes con la orden `brctl show` podemos apreciar que nos ha creado un puente de red hacia el contenedor y le ha asignado la interfaz que antes nos salía en última posición.

![Ejercicio 2 - Foto 4](http://ubuntuone.com/0xtPssPK7gpJUIQje2sVaX)

# Ejercicios del 15-11-2013

## Ejercicio 3

**1. Crear y ejecutar un contenedor basado en Debian.**

La creación y ejecución de dicho contenedor ya se explica en el ejercicio 2. El contenedor utiliza un sistema operativo Ubuntu y se llama una-caja.

**2. Crear y ejecutar un contenedor basado en otra distribución, tal como Fedora.**

Antes de poder crear el contenedor de Fedora tenemos que instalar los siguientes paquetes: `curl` y `yum`. Dichos paquetes se instalan con las siguientes órdenes:

> ```
> sudo apt-get install curl
> sudo apt-get install yum 
> ```

Una vez instalados los paquetes anteriores procedemos a la creación del contenedor con la siguiente orden:

`sudo lxc-create -t fedora -n fedora12 -- -R 12`

Una vez instalado el contenedor de Fedora en su versión 12, accedemos a él con la siguiente orden:

`sudo lxc-start -n fedora12`

Si listamos a continuación los contenedores que llevamos creados con la orden `lxc-list`, podemos apreciar que tenemos dos contenedores. 
Uno en estado ejecutándose, que es el contenedor llamado `fedora12` que lo acabamos de crear y el segundo, que es el contenedor llamado `una-caja` que es el contenedor de Ubuntu utilizado en el punto anterior.

![Ejercicio 3](http://ubuntuone.com/4unrZrSG4tNegD06Uom60V)

## Ejercicio 4

**1. Instalar lxc-webpanel y usarlo para arrancar, parar y visualizar las máquinas virtuales que se tengan instaladas.**

Para instalar lxc-webpanel tenemos que ser superusuarios e instalarlo con la siguiente orden:

`wget http://lxc-webpanel.github.io/tools/install.sh -O - | bash`

Una vez instalado, abrimos un navegador web y accedemos a él con la siguiente dirección web:

`http://localhost:5000/`

y el usuario y contraseña para acceder a la pagina principal de lxc-webpanel es `admin/admin`

![Ejercicio 4 - Foto 1](http://ubuntuone.com/2dMe6HZiTrI0vozu2KJGCO)

Una vez en la página principal de lxc-webpanel podemos visualizar los contenedores que tenemos y arrancarlos y pararlos a nuestro gusto. 
Podemos apreciar que tenemos ahora mismo dos contenedores creados, dichos contenedores han sido creados en el ejercicio anterior, y si arrancamos uno podemos apreciar que dicha página cambia ligeramente pasando el contenedor que acabamos de arrancar a estado corriendo.

![Ejercicio 4 - Foto 2](http://ubuntuone.com/4YBGYq6L5IJF2LjLEh0Kj0)

**2. Desde el panel restringir los recursos que pueden usar: CPU shares, CPUs que se pueden usar (en sistemas multinúcleo) o cantidad de memoria.**

Para ello en el menú de la izquierda pinchamos sobre el contenedor al cuál queramos modificarle sus recursos. En mi caso, voy a restringirle los recursos al contenedor de Ubuntu llamado `una-caja`. 

Los recursos que voy a asignarle son: 

* Le voy a limitar la memoria a 1024 MB.
* La memoria de intercambio más la memoria lo limito al doble de lo anterior, es decir, a 2048 MB. 
* Le voy a asignar solo una CPU de las dos de las que dispone mi PC, la CPU 1.
* Además solo va a poder usar el 50% de los recursos de dicha CPU. 

![Ejercicio 4 - Foto 3](http://ubuntuone.com/3xfxGi1EIFrQ2AWmAhFMiv)

Una vez que introduzcamos los cambios, aplicamos dichos cambios. Si ahora arrancamos nuestro contenedor, este ya tendrá los cambios introducidos en dicha página. 

## Ejercicio 5

**Comparar las prestaciones de un servidor web en una jaula y el mismo servidor en un contenedor. Usar nginx.**

En una jaula ya tenemos instalado nginx de un ejercicio del tema anterior. Solo queda acceder al fichero de inicio y 
modificarlo un poco para poder distinguirlo del contenedor. Dicho fichero se encuentra en 
`/usr/share/ngnix/html/index.html`, una vez modificado el fichero pasamos a comprobar que el servicio nginx está 
ejecutándose en la jaula. 

![Ejercicio 5 - Foto 1](http://ubuntuone.com/4YLhBC8K7Nt4UkdIiaIGix)

Ahora solo queda instalar nginx en el contenedor que hemos creado en el ejercicio 3 de Ubuntu. Es tan fácil como poner 
`sudo apt-get install nginx` y nginx se instalará en nuestro contenedor sin ningún problema. Una vez instalado nginx 
vamos a modificar su fichero de inicio para distinguirlo de la jaula. Dicho fichero se encuentra en 
`/usr/share/ngnix/www/index.html`, una vez modificado el fichero pasamos a comprobar que el servicio nginx está 
ejecutándose en el contenedor. 

![Ejercicio 5 - Foto 2](http://ubuntuone.com/1zDtKX3EbBfzVivKSD9kEw)

Una vez que nginx funciona en ambos sitios, vamos a mirar que dirección IP tiene cada sitio para ir a un navegador y 
poder visualizar su archivo de inicio. La jaula tiene la misma dirección IP que el sistema anfitrión, por eso en el 
navegador poniendo `localhost` podemos visualizar que nginx funciona y nos muestra su archivo de inicio.

![Ejercicio 5 - Foto 3](http://ubuntuone.com/0TUtwKrAJTkOTcDE36k64m)

En cambio, en el contenedor la dirección IP no es la misma que el sistema anfitrión, ya que el contenedor nos crea una 
nueva interfaz virtual y le da su propia dirección IP. Dicha dirección puede visualizarse con el comando `ifconfig` y su
dirección es: 

![Ejercicio 5 - Foto 4](http://ubuntuone.com/1JGMmHrpxnssZtCTyr2exy)

Introducimos dicha dirección IP en el navegador y visualizamos la página de inicio:

![Ejercicio 5 - Foto 5](http://ubuntuone.com/5WN47PfAfOuO4gzv6ULD9c)

Ambos servidores funcionan correctamente, por lo que vamos a medir las prestaciones de cada servidor. Para realizar las 
mediciones voy a utilizar el Apache Benchmark `ab`, para ello lo vamos a instalar en nuestro sistema anfitrión y lo 
lanzamos para poder recoger los datos y comparar ambos sistemas. Si dicho benchmark no lo tenemos instalado en nuestro 
sistema, la instalación es tan fácil como poner en la consola `sudo apt-get install apache2-utils`. 

Al benchmark le voy a pedir que realice 10000 peticiones a la página principal de cada sistema y que estas peticiones 
las realice de 100 en 100. De todas las métricas que nos ofrece este benchmark, voy a centrar el estudio en tres 
métricas: el tiempo que tarda en ejecutar dicho test, las respuestas por segundo que ofrece y el tiempo que tarda en 
cada respuesta. Para poder obtener datos concretos y fiables, voy a lanzar 10 veces seguidas dicho benchmark y tomar 
medias y desviaciones estándar de las métricas anteriores. 

Primero lo lanzamos sobre la jaula: 

![Ejercicio 5 - Foto 6](http://ubuntuone.com/2REhq8Ym7OH6UV0z2mHmcN)

Recogemos los datos de cada una de las 10 ejecuciones y después lo lanzamos sobre el contenedor:

![Ejercicio 5 - Foto 7](http://ubuntuone.com/5Ltv12Eu3lzDrSAV5FGjVW)

Una vez echa toda la batería de pruebas la tabla con los resultados es la siguiente: 

|             |                      |      Jaula      |                                |                      |    Contenedor   |                                |
|:-----------:|:--------------------:|:-----------------------:|:------------------------------:|:--------------------:|:-----------------------:|:------------------------------:|
|             | Time taken for tests (seconds) | Requests per second | Time per request (ms) | Time taken for tests (seconds) | Requests per second | Time per request (ms) |
|   Ejecución 1  |        1,091        |         9162,4        |             10,914            |        1,438        |         6952,26        |             14,384            |
|   Ejecución 2  |        1,116        |         8962,09        |             11,158            |        1,434        |         6973,63        |             14,34            |
|   Ejecución 3  |        1,258        |         7952,07        |             12,575            |        1,317        |         7594,2        |             13,168            |
|   Ejecución 4  |        1,266        |         7899,2        |             12,66            |        1,474        |         6782,45        |             14,744            |
|   Ejecución 5  |        1,137        |         8797,13        |            11,367            |        1,491        |         6707,3        |             14,909            |
|   Ejecución 6  |        1,277        |         7833,68        |            12,765            |        1,47        |         6803,17        |             14,699            |
|   Ejecución 7  |        1,138        |         8790,81        |            11,376            |        1,469        |         6805,47        |             14,694            |
|   Ejecución 8  |        1,146        |         8728,24        |            11,457            |        1,559        |         6412,51        |             15,595            |
|   Ejecución 9  |        1,219        |         8205,59        |            12,187            |        1,488        |         6718,51        |             14,884            |
|  Ejecución 10  |        1,288        |         7760,98        |             12,885            |        1,494        |         6692,9        |             14,941            |
|             |                      |                         |                                |                      |                         |                                |
|    Media    |        1,1936        |        8409,219        |            11,9344            |        1,4634        |        6844,24        |            14,6358            |
| Desviación  |         0,0752849402        |         530,4963393931        |            0,7527641212            |         0,0619788494        |         305,8164193325        |             0,6212782164            |

Observando los datos de desviación podemos ver que el dato que es más fiable para guiarnos a la hora de comparar ambos 
servidores es el tiempo de ejecución. Por lo tanto podemos ver que el mejor rendimiento lo obtenemos en el servidor que 
está instalado en la jaula. Esto es debido a que como la jaula está directamente conectada a la misma interfaz de red 
que el sistema anfitrión, tarda menos en ejecutar el benchmark que el contenedor. Ya que este se conecta a través de una
interfaz virtual, lo que provoca ese pequeño retardo a la hora de ejecutar el benchmark y hace que el servidor instalado
en la jaula sea mejor.  

# Ejercicios del 22-11-2013

## Ejercicio 6

**1. Instalar juju.**

Para instalar juju, lo primero que tenemos que hacer es añadir el repositorio de la aplicación con la siguiente orden:

`sudo add-apt-repository ppa:juju/stable`

Actualizamos los repositorios de Ubuntu con:

`sudo apt-get update`

E instalamos juju: 

`sudo apt-get install juju-core`

**2. Usándolo, instalar MySql en un táper.**

Para empezar a utilizar juju, tenemos que inicializarlo con:

`sudo juju init`

esta orden crea el archivo con la información sobre los entornos de trabajo en `~/.juju/environments.yaml`. Como 
queremos trabajar en local y en el fichero viene por defecto para trabajar sobre la nube de Amazon, lo único que tenemos
que hacer es acceder a dicho fichero y cambiar `default:amazon` por `default:local`. 

Una vez echo esto nos queda un detalle para poder trabajar en local, instalar MongoDB. Si en nuestro ordenador no lo 
tenemos ya instalado, lo instalamos con la siguiente orden:

`sudo apt-get install mongodb-server`

Ahora vamos a proceder a la instalación de MySQL, pero antes establecemos que vamos a trabajar en el entorno de trabajo 
local con: 

`sudo juju switch local`

A juju solo le gusta usar un táper que el mismo haya creado y no uno creado por nosotros anteriormente. Para ello 
creamos un nuevo táper con la siguiente orden:

`sudo juju bootstrap`

Una vez creado el táper, podemos instalar servicios dentro de él. Para instalar estos servicios utilizamos charms de los
que provee el propio sistema, concretamente vamos a utilizar el de MySQL para instalarlo. Para ello hacemos uso de la 
siguiente orden:

`sudo juju deploy mysql`

Una vez instalado vamos a comprobar su estado con la orden: 

`sudo juju status`

![Ejercicio 6 - Foto 1](http://ubuntuone.com/4Rq8OKND9bPzBKuu94sWG8)

En la imagen anterior podemos apreciar las máquinas 0 y 1. La máquina 0 corresponde al sistema anfitrión y la máquina 1 
es nuestro táper de juju y como servicio instalado aparece mysql. Dicho servicio tiene un error, este error lo podemos 
solucionar con la siguiente orden: 

`sudo juju resolved --retry mysql/0 `

Volvemos a visualizar el estado de ambas máquinas y ya podemos observar que dicho error ha sido solucionado y el 
servicio de mysql instalado en nuestro táper de juju funciona correctamente. 

![Ejercicio 6 - Foto 2](http://ubuntuone.com/3zD39A7PRctHsVv0TwBinh)

## Ejercicio 7

**1. Destruir toda la configuración creada anteriormente**

Para destruir toda la configuración anterior, debemos hacerlo en orden inverso a como lo hemos montado. Para ello 
primero eliminamos el servicio mysql:

`sudo juju destroy-service mysql`

A continuación, destruimos la máquina con:

`sudo juju destroy-environment`

y mostramos los estados de las máquinas con: 

`sudo juju status`

![Ejercicio 7](http://ubuntuone.com/4yhLFI4YUgJFfZAZbXH8PI)

**2. Volver a crear la máquina anterior y añadirle mediawiki y una relación entre ellos.**

Realizamos todos los pasos del ejercicio anterior, añadimos el servicio mediawiki y una relación entre este y mysql. Los
pasos son: 

> ```
> sudo juju bootstrap
> sudo juju deploy mediawiki
> sudo juju deploy mysql
> sudo juju add-relation mediawiki:db mysql
> sudo juju expose mediawiki
> ```

**3. Crear un script en shell para reproducir la configuración usada en las máquinas que hagan falta.**

Para ello lo único que tenemos que realizar es meter todas las ordenes del apartado anterior en un script y lanzarlo 
como superusuario. El script es el siguiente:

> ```
> #!/bin/bash 
> juju bootstrap 
> juju deploy mediawiki 
> juju deploy mysql 
> juju add-relation mediawiki:db mysql 
> juju expose mediawiki 
> ``` 

Guardamos dicho scritpt, le damos permisos de ejercución con: 

`chmod +x script.sh`

y lo lanzamos:

`sudo ./script.sh` 

Cuando termine de ejecutarse dicho script, tendremos nuestro contenedor funcionando. 

## Ejercicio 8

**Instalar libvirt.**

Antes de instalar **libvirt** debemos mirar que nuestro hardware soporte la extensión de virtualización necesaria para 
KVM. Para ello debemos introducir en la consola el comando `kvm-ok` y visualizar su salida para ver si nuestro ordenador
es compatible o no. 

![Ejercicio 8 - Foto 1](http://ubuntuone.com/6Js0obLmU2fbaJWjNUtjaR)

Y podemos apreciar que nuestro ordenador si es compatible. Una vez echo esto procedemos a instalar la librería de 
**libvirt** con la siguiente orden:

`sudo apt-get install kvm libvirt-bin`

Una vez que se han instalado todos los paquetes, debemos indicar a **libvirt** qué usuario va a manejar las máquinas 
virtuales que vamos a crear con esta librería. Por lo tanto, lo añadimos con la siguiente orden: 

`sudo adduser $USER libvirtd`

![Ejercicio 8 - Foto 2](http://ubuntuone.com/1ilIdUjC6GIiB9ICFQ6RWV)

**Libvirtd** también nos ofrece una shell para la gestión de línea de comandos. Dicha shell puede ser visualizada con el
comando `virsh`. 

![Ejercicio 8 - Foto 3](http://ubuntuone.com/6FVRI1mNw8vWcqhqeJpHHF)

En dicha shell, podemos crear e interactuar con las distintas máquinas virtuales que creemos con esta librería.

## Ejercicio 9

**Instalar un contenedor usando virt-install.**

Lo primero que debemos hacer es instalar el propio **virt-install**, para ello introducimos la siguiente orden:

`sudo apt-get install virtinst`

A continuación instalamos **virt-viewer**, que nos va a permitir interactuar con la máquina virtual a través de una 
interfaz gráfica, haciéndonos un poco más fácil el trabajo. El paquete lo instalamos con: 

`sudo apt-get install virt-viewer`

El siguiente paso es descargarse una imagen ISO del sistema que vamos a instalar. En mi caso voy a descargarme la ISO de
Ubuntu Server 12.04.3. Una vez descargada la imagen, procedemos a comenzar la instalación con **virt-install**. Para 
ello introducimos la siguiente orden:

> ```
> sudo virt-install -n ubuntuserver -r 512 --disk path=/var/lib/libvirt/images/ubuntuserver.img,bus=virtio,size=5 -c 
> ubuntu-12.04.3-server-i386.iso --accelerate --network network=default,model=virtio --connect=qemu:///system --vnc 
> --noautoconsole -v
> ```

en donde cada una de las opciones significa: 

* **-n**: nombre de la máquina virtual.
* **-r**: cantidad de memoria RAM en MB que va a utilizar la máquina virtual.  
* **--disk path=/var/lib/libvirt/images/ubuntuserver.img,bus=virtio,size=5**: la ruta en la que se va a almacenar el 
disco virtual, el bus que va a utilizar dicho disco y el tamaño en GB que va a tener. 
* **-c**: imagen ISO que se va a utilizar para instalar el sistema.
* **--accelerate**: para activar la tecnología de aceleración del kernel.
* **--network network=default,model=virtio**: la interfaz de red que va a utilizar la máquina virtual y el modelo de la 
misma. 
* **--connect=qemu:///system**: el hipervisor al cual se va a conectar. 
* **--vnc**: para exportar la consola virtual del huésped. 
* **--noautoconsole**: para evitar que se conecte automáticamente a la consola de la máquina virtual. 
* **-v**: para crear un huésped totalmente virtualizado. 

![Ejercicio 9 - Foto 1](http://ubuntuone.com/4VRIS1mrLpEFuXgeOW0uvm)

Ahora si listamos las máquinas virtuales existentes con: 

`sudo virsh -c qemu:///system list`

![Ejercicio 9 - Foto 2](http://ubuntuone.com/5N0dszXutbLN4Mk957aEqD)

Podemos apreciar que la máquina se encuentra en estado ejecutando. Para poder continuar con la instalación desde el 
entorno gráfico, debemos conectarnos a la máquina virtual que acabamos de crear con:

`virt-viewer -c qemu:///system ubuntuserver`

y seguir los pasos hasta terminar de instalar nuestra máquina virtual.

# Ejercicios del 17-01-2014

## Ejercicio 10

**Instalar docker.**

Para poder trabajar con docker necesitamos tener una versión del kernel superior a la 3.8, si tenemos una más baja, como 
en mi caso, actualizamos la versión del kernel con los siguientes comandos: 

> ```
> sudo apt-get update
> sudo apt-get install linux-image-generic-lts-raring linux-headers-generic-lts-raring
> sudo reboot 
> ```

Una vez que el ordenador se reinicie y tenga una versión del kernel superior a la 3.8, instalamos docker ejecutando el 
siguiente script:

`curl -s https://get.docker.io/ubuntu/ | sudo sh`
