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

## Ejercicio 3

**Crear imágenes con estos formatos (y otros que se encuentren tales como VMDK) y manipularlas a base de montarlas o** 
**con cualquier otra utilidad que se encuentre.**

Vamos a empezar creando una imagen en formato raw, cuyo formato evita los espacios sin asignar y que se representan por 
metadatos. Por lo tanto, puede usar en el almacenamiento físico menos espacio del asignado inicialmente y lo admiten la 
mayoría de los sistemas operativos modernos.

Para crearlo utilizamos la siguiente orden: 

`dd of=prueba.img bs=1k seek=5242879 count=0`

aunque también podemos utilizar:

`fallocate -l 5M prueba1.img`

y para visualizar ambas imágenes creadas anteriormente utilizamos: 

> ```
> ls -lks prueba.img
> ls -lks prueba1.img
> ```

![Ejercicio 3 - Foto 1](http://ubuntuone.com/6o4YrwGMtXabDzA8XOYuqk)

La siguiente imagen que voy a crear, va a estar en formato qcow2. Este formato fue usado inicialmente por QEMU pero más 
adelante ha sido generalizado a casi todos los gestores de MVs de Linux. Es un sistema que usa Copy-on-write para 
mantener la coherencia del resultado en memoria con lo que hay en disco a la vez que se optimiza el acceso al mismo.

Para crear las imágenes utilizamos:

`qemu-img create -f qcow2 fichero-cow.qcow2 5M`

y para saber información de dichas imágenes utilizamos:

`qemu-img info fichero-cow.qcow2`

![Ejercicio 3 - Foto 2](http://ubuntuone.com/2O8mXG1JeUkuLv1DynbaC9)

Por último, voy a crear una imagen en formato vmdk. Para ello voy a utilizar QEMU y se crea de la misma manera a como 
hemos creado en formato qcow2. 

![Ejercicio 3 - Foto 3](http://ubuntuone.com/5Jv3XzqG6WL0KPScNQgSH3)

Para montar la imagen creada anteriormente como un dispositivo **loop**, realizamos lo siguiente: 

`sudo mount -o loop,offset=32256 imagen-vmdk.vmdk /mnt/mountpoint`

y como dispositivo **NBD**:

> ```
> sudo modprobe nbd max_part=16
> sudo qemu-nbd -c /dev/nbd0 imagen-vmdk.vmdk
> sudo partprobe /dev/nbd0
> sudo mount /dev/nbd0 /mnt/image
> ```

## Ejercicio 4

**Crear uno o varios sistema de ficheros en bucle usando un formato que no sea habitual (xfs o btrfs) y comparar las** 
**prestaciones de entrada/salida entre sí y entre ellos y el sistema de ficheros en el que se encuentra, para** 
**comprobar el overhead que se añade mediante este sistema.**

Lo primero que tenemos que hacer es crear las imágenes con qemu, tal y como lo hemos realizado en el ejercicio anterior:

> ```
> qemu-img create -f raw xfs.img 512M
> qemu-img create -f raw btrfs.img 512M
> ```

**Nota**: Para trabajar con `btrfs` es recomendable darle a la imagen un tamaño de al menos 256MB.

![Ejercicio 4 - Foto 1](http://ubuntuone.com/5PLQU46H8Cjv8OptoGmSsQ)

A continuación, convertimos ambas imágenes en sistemas de ficheros en bucle:

> ```
> sudo losetup -v -f xfs.img
> sudo losetup -v -f btrfs.img
> ```

![Ejercicio 4 - Foto 2](http://ubuntuone.com/46kmxNXrlQYnT3HTjiI5Tx)

Le damos el formato correspondiente a cada una:

> ```
> sudo mkfs.xfs /dev/loop3
> sudo mkfs.btrfs /dev/loop4
> ```

Es posible que las órdenes `mkfs.xfs` y `mkfs.btrfs` no funcionen. Es porque nos faltan instalar los siguientes 
paquetes:

> ```
> sudo apt-get install xfsprogs
> sudo apt-get install btrfs-tools
> ```

Una vez instalados dichos paquetes ya si nos funcionan las órdenes: 

![Ejercicio 4 - Foto 3](http://ubuntuone.com/6wLGb7QwYWTsqLuFu1CbJE)

Y los montamos con:

> ```
> sudo mount /dev/loop3 /mnt/loop3/
> sudo mount /dev/loop4 /mnt/loop4/
> ```

![Ejercicio 4 - Foto 4](http://ubuntuone.com/6EIqBOHGwunwJNdpQ53GUO)

Al principio nos aparece un error y es porque los directorios `/mnt/loop3` y `/mnt/loop4` no existen. Para solucionar 
este problema lo único que tenemos que hacer es crearlos con:

> ```
> sudo mkdir -p /mnt/loop3/
> sudo mkdir -p /mnt/loop4
> ```

Una vez creados ya no nos da ningún problema a la hora de montarlos:

![Ejercicio 4 - Foto 5](http://ubuntuone.com/6CqE02SIs4Jqf1gUhXKsAM)

Por último, nos queda comprobar que aparecen como dispositivos montados en el sistema: 

![Ejercicio 4 - Foto 6](http://ubuntuone.com/04K7DeBSAVAxxR9XHWDhwX)

Para ver cuanto tiempo tarda en copiarse un archivo que tenemos en nuestro sistema a cada uno de los sistemas en bucle, 
voy a crear un archivo de 15MB con:

`dd if=/dev/urandom of=archivo bs=100 count=150000`

![Ejercicio 4 - Foto 7](http://ubuntuone.com/5qAGF8QFXAFtvM2jX933Jv)

Una vez creado el archivo, lo copiamos a cada uno de los sistemas en bucle y vemos cuanto tiempo ha tardado en copiarse:

> ```
> sudo time cp archivo /mnt/loop3/archi_xfs
> sudo time cp archivo /mnt/loop4/archi_btrfs
> ```

![Ejercicio 4 - Foto 8](http://ubuntuone.com/4useRBGaV5WvlbwyGwYTVO)

En donde podemos apreciar que tarda mucho menos en copiar al sistema en bucle `btrfs` que al `xfs`. Pero si tuviera que 
elegir uno de los dos me quedo con `xfs` ya que `btrfs` todavía está en fase experimental.

# Ejercicios del 13-12-2013

## Ejercicio 5

**Instalar ceph en tu sistema operativo.**

Es tan sencillo como instalar el siguiente paquete, que ya trae todas las dependencias necesarias para su correcto 
funcionamiento. Para ello utilizamos la siguiente orden:

`sudo apt-get install ceph-mds` 

## Ejercicio 6

**Crear un dispositivo ceph usando BTRFS o XFS.**

Ya que lo tenemos instalado del ejercicio anterior, solo nos queda configurarlo. Para ello empezamos creando el 
directorio en donde se va a almacenar la información de **ceph** con la siguiente orden:

`sudo mkdir -p /srv/ceph/{osd,mon,mds}`

Ahora procedemos a crear el fichero de configuración de **ceph** en `/etc/ceph/ceph.conf` y lo rellenamos tal y como se 
muestra a continuación: 

![Ejercicio 6 - Foto 1](http://ubuntuone.com/4rbbIhoMIGfsqEzmSvgihb)

Ahora necesitamos crear un sistema bucle en formato `xfs` tal y como hicimos anteriormente en el ejercicio 4: 

> ```
> qemu-img create -f raw ceph.img 1G
> sudo losetup -v -f ceph.img
> sudo mkfs.xfs /dev/loop1
> ```

![Ejercicio 6 - Foto 2](http://ubuntuone.com/3wfBzwuHmcrOv8x9IBw0cO)

Una vez creado, tenemos que crear un directorio que va a ser utilizado para el servidor de objetos:

`sudo mkdir /srv/ceph/osd/osd.0`

y creamos el sistema de ficheros de objetos:

`sudo /sbin/mkcephfs -a -c /etc/ceph/ceph.conf`

![Ejercicio 6 - Foto 3](http://ubuntuone.com/56ENOQJW4iGGOhdF2T8o0W)

Iniciamos el servicio con:

`sudo /etc/init.d/ceph -a start`

![Ejercicio 6 - Foto 4](http://ubuntuone.com/5m9A3yf8sKwINbWBth51JO)

Comprobamos si el estado de **ceph** es correcto con:

`sudo ceph -s`

![Ejercicio 6 - Foto 5](http://ubuntuone.com/5qa1O4pjIWSGiX5LinCNB5)

Para terminar, creamos el directorio en donde lo vamos a montar:

`sudo mkdir /mnt/ceph`

y lo montamos:

`sudo mount -t ceph ubuntu:/ /mnt/ceph`

## Ejercicio 7

**Almacenar objetos y ver la forma de almacenar directorios completos usando ceph y rados.**

Para trabajar con **rados**, lo primero que tenemos que hacer es crear la piscina:

`sudo rados mkpool ej7`

y comprobar que se ha creado:

![Ejercicio 7 - Foto 1](http://ubuntuone.com/2YwNs3Ngbf53CDU2qxKJZk)

Podemos ver lo que hay almacenado en la piscina con:

`sudo rados df`

![Ejercicio 7 - Foto 2](http://ubuntuone.com/77E876Gp71dt3AFi3J8UGd)

Como todavía no hemos almacenado nada, la piscina se encuentra vacía. Por lo tanto vamos a introducir un archivo en la 
piscina con:

`sudo rados put -p ej7 objeto prueba1.img` 

Ahora si miramos lo que hay almacenado en la piscina, vemos que ya no está vacía. Y si listamos el contenido de la 
piscina, aparece el archivo que acabamos de almacenar:

![Ejercicio 7 - Foto 3](http://ubuntuone.com/5mlsUZzBaaSR6TkBgLhCRO)

En el caso en que queramos subir un directorio completo, lo que tenemos que hacer es comprimir dicho directorio y subir 
el archivo comprimido como acabamos de subir el archivo de prueba que hemos subido. Las órdenes para realizar estos 
pasos son:

> ```
> tar -zcvf prueba.tar.gz IV
> sudo rados put -p ej7 carpeta prueba.tar.gz
> sudo rados df
> sudo rados ls -p ej7
> ```

![Ejercicio 7 - Foto 4](http://ubuntuone.com/1QLD2Lhad3d5UO21atO7eR)

# Ejercicios del 16-12-2013

## Ejercicio 8

**Tras crear la cuenta de Azure, instalar las herramientas de línea de órdenes (Command line interface, cli) del mismo**
**y configurarlas con la cuenta Azure correspondiente.**

Para empezar a instalar Windows Azure Cross-Platform Command-Line Interface, necesitamos tener instalada en nuestro 
ordenador la librería de JavaScript **Node.js**. Para instalar dicha librería, tenemos que añadir el repositorio desde 
el cual se va a poder instalar la librería. Para ello utilizamos la siguiente orden:

`sudo add-apt-repository ppa:chris-lea/node.js`

![Ejercicio 8 - Foto 1](http://ubuntuone.com/57wwFfRnd7Kt0wocOI08kt)

Una vez que haya terminado, actualizamos los repositorios de Ubuntu con:

`sudo apt-get update`

y procedemos a instalar la librería con:

`sudo apt-get install nodejs`

Una vez que se ha instalado la librería, ya podemos instalar Windows Azure Cross-Platform Command-Line Interface con la 
siguiente orden:

`npm install azure-cli`

Una vez que ya hemos instalado Azure en nuestro sistema, debemos acceder a esta dirección web:

`http://go.microsoft.com/fwlink/?LinkId=254432`

registrarnos con nuestra cuenta de Azure y descargarnos nuestro fichero de configuración. Una vez que se ha descargado 
el fichero, lo importamos con:

`azure account import Azpad245QYQ8005-**-**-****-credentials.publishsettings`

![Ejercicio 8 - Foto 2](http://ubuntuone.com/2eDqPwx62gDSUaTpSS5aux)

Ahora tal y como nos dice la captura anterior, debemos borrar el archivo que acabamos de importar ya que este contiene 
información importante. Lo borramos con:

`rm Azpad245QYQ8005-**-**-****-credentials.publishsettings`

Comprobamos que la cuenta ha sido importada correctamente con:

`azure account list`

![Ejercicio 8 - Foto 3](http://ubuntuone.com/5VzMzNI6kv0e7NI1zadgnp)

Ya solo nos queda crear una cuenta de almacenamiento, para ello seguimos los siguientes pasos:

> ```
> azure account storage create jcastilloprez
> azure account storage keys list jcastilloprez
> export AZURE_STORAGE_ACCOUNT=jcastilloprez
> export AZURE_STORAGE_ACCESS_KEY=LLAVE_PROPORCIONADA_POR_AZURE
> echo $AZURE_STORAGE_ACCOUNT
> echo $AZURE_STORAGE_ACCESS_KEY
> ```

![Ejercicio 8 - Foto 4](http://ubuntuone.com/0ocS0MaPrM85YJwB5Lzutm)

Acabamos de crear nuestra cuenta de almacenamiento, si queremos ver que se ha creado correctamente, lo único que tenemos
que hacer es irnos a la web de Windows Azure:

`https://manage.windowsazure.com`

y ver como en el panel de control de la página, aparece nuestra cuenta de almacenamiento. 

![Ejercicio 8 - Foto 5](http://ubuntuone.com/5O7GS5pfW5xWk6qVo0Acuy)

## Ejercicio 9

**Crear varios contenedores en la cuenta usando la línea de órdenes para ficheros de diferente tipo y almacenar en** 
**ellos las imágenes en las que capturéis las pantallas donde se muestre lo que habéis hecho.**

Para subir las imágenes que hagamos sobre este ejercicio en la cuenta de almacenamiento creada en el ejercicio anterior,
vamos a crear un contenedor que va a contener las imágenes. Dicho contenedor se crea con:

`azure storage container create imagenes -p blob`

![Ejercicio 9 - Foto 1](http://ubuntuone.com/3AoAW6NhrL1fnK3Xpg4XYE)

Ahora para subir la imagen anterior al contenedor que acabamos de crear, realizamos lo siguiente:

`azure storage blob upload Ej9-foto1.png imagenes`

![Ejercicio 9 - Foto 2](http://ubuntuone.com/3GE5qZCqwISoAqeuioSPMd)

Ya está subida la imagen y por lo tanto está accesible en la siguiente dirección: 

`http://jcastilloprez.blob.core.windows.net/imagenes/Ej9-foto1.png`

Realizamos la misma operación de subida de está última captura:

`azure storage blob upload Ej9-foto2.png imagenes`

y se encuentra en la dirección:

`http://jcastilloprez.blob.core.windows.net/imagenes/Ej9-foto2.png`

## Ejercicio 10

**Desde un programa en Ruby o en algún otro lenguaje, listar los blobs que hay en un contenedor, crear un fichero con** 
**la lista de los mismos y subirla al propio contenedor. Muy meta todo.**

Lo primero que tenemos que hacer es instalar en nuestro sistema la gema de Ruby para Azure. Dicha gema se instala con la
siguiente orden:

`sudo gem install azure`

Una vez que hemos instalado la gema, el código del programa que he realizado es el siguiente:

![Ejercicio 10](http://ubuntuone.com/1b6XS0SqNAfBqq4zM8pAx3)
