# Ejercicios del 20-13-2013

## Ejercicio 1

**Instalar los paquetes necesarios para usar KVM. Se pueden seguir estas instrucciones. Ya lo hicimos en el primer** 
**tema, pero volver a comprobar si nuestro sistema está preparado para ejecutarlo o hay que conformarse con la** 
**paravirtualización.**

Antes de nada, debemos comprobar que nuestro sistema soporte virtualización con la orden 
`egrep -c '(vmx|svm)' /proc/cpuinfo` y obtener un valor distinto de 0. También debemos comprobar que el sistema esté 
preparado para ejecutar **KVM** y no es necesario que nos conformemos con la paravirtualización:

![Ejercicio 1](http://ubuntuone.com/5r6AJaNlc312kYK8BrCFFv)

y como podemos observar en la imagen anterior, vemos que nuestro sistema soporta virtualización, puesto que el valor que 
nos da la salida es distinto de 0 y que **KVM** está listo para ser utilizado. 

Una vez que hemos comprobado todo esto, procedemos a instalar todos los paquetes que vamos a necesitar para utilizar 
**KVM**. Para ello utilizamos la siguiente orden: 

`sudo apt-get install qemu-kvm qemu-system libvirt-bin virtinst virt-manager`

## Ejercicio 2

**1. Crear varias máquinas virtuales con algún sistema operativo libre, Linux o BSD. Si se quieren distribuciones que** 
**ocupen poco espacio con el objetivo principalmente de hacer pruebas se puede usar CoreOS (que sirve como soporte para**
**Docker) GALPon Minino, hecha en Galicia para el mundo, Damn Small Linux, SliTaz (que cabe en 35 megas) y ttylinux** 
**(basado en línea de órdenes solo).**

Lo primero que tenemos que hacer es activar el módulo del kernel de **KVM** porque puede que este no esté cargado por 
defecto. Para ello utilizamos la siguiente orden:

`sudo modprobe kvm-intel`

Ahora que ya hemos activado el módulo, procedemos a crear la primera máquina virtual. Empezamos por instalar SliTaz, para
ello nos descargamos la imagen ISO de dicho SO de su página web que es: 

`http://www.slitaz.org/en/get/#stable`

Una vez que nos hemos descargado la imagen, procedemos a crear un disco duro virtual con la siguiente orden: 

`qemu-img create -f raw SliTaz.img 100M`

![Ejercicio 2 - Foto 1](http://ubuntuone.com/0eOdfy6wQVSeVSH8edmSP0)

y lanzamos el Sistema Operativo con: 

`qemu-system-x86_64 -hda ./SliTaz.img -cdrom slitaz-4.0.iso`

![Ejercicio 2 - Foto 2](http://ubuntuone.com/4dZNgcIqezA8F4DkCZPkuE)

Ahora vamos a realizar los mismos pasos, pero esta vez vamos a lanzar ttylinux. Nos descargamos la imagen ISO del 
siguiente enlace: 

`http://ttylinux.net/dloadPC-x86_64.html`

creamos el disco duro virtual: 

![Ejercicio 2 - Foto 3](http://ubuntuone.com/5w1z720ET8O7msuxSkzVfa)

y lanzamos el Sistema Operativo: 

![Ejercicio 2 - Foto 4](http://ubuntuone.com/3pA7Vp0kL4eYjNFBInmCXE)

Los Sistema Operativos instalados antes son muy pocos pesados, por lo tanto, vamos a pasar a instalar un Sistema 
Operativo un poco más pesado como es CentOS. Como la instalación de este Sistema Operativo es más pesada, si utilizamos 
las mismas opciones que hemos utilizado con los sistemas anteriores puede que la instalación tarde demasiado tiempo o 
incluso que no llegue a instalarse correctamente. Para ello vamos a utilizar el Gestor de máquinas virtuales de KVM.  

Lo que si podemos hacer es crearnos el disco duro virtual para luego poder arrancar el Sistema Operativo con QEMU. Para 
ello utilizamos la misma orden que anteriormente pero añadiéndole la opción `preallocation=metadata`:

![Ejercicio 2 - Foto 5](http://ubuntuone.com/4bV1RVzvP2LOIqz3cNglap)

Una vez que hemos creado el disco duro virtual, abrimos el Gestor de máquinas virtuales de KVM y seguimos los pasos que 
nos va indicando el programa para crear la nueva máquina virtual. 

Introducimos el nombre que le vamos a dar a la máquina virtual:

![Ejercicio 2 - Foto 6](http://ubuntuone.com/4T1m7lRhdJVqwXlJDbw9U9)

Indicamos donde se encuentra la imagen ISO del Sistema Operativo: 

![Ejercicio 2 - Foto 7](http://ubuntuone.com/0aEsoWnsaaUSA8pdY2mLiu)

Le ponemos cuanta cantidad de memoria RAM y CPUs va a tener la máquina virtual:

![Ejercicio 2 - Foto 8](http://ubuntuone.com/1klRQorhGpO5RUcrrbn0SN)

Le indicamos en donde se encuentra el disco duro virtual que creamos anteriormente:

![Ejercicio 2 - Foto 9](http://ubuntuone.com/3HqndzYsFzaAs6EyJQLfTh)

Terminamos de crear la máquina virtual:

![Ejercicio 2 - Foto 10](http://ubuntuone.com/2gjXYGd9uU9DbCOMbYKh0v)

y la arrancamos para empezar el proceso de instalación:

![Ejercicio 2 - Foto 11](http://ubuntuone.com/7UwPxOtiN8bgAYSPMnILSA)

Cuando termine el proceso de instalación, ya tendremos nuestra máquina virtual de CentOS creada correctamente: 

![Ejercicio 2 - Foto 12](http://ubuntuone.com/3iB3lG50vfOMvZ6LgWgPNe)

Ya que hemos creado la máquina virtual con el Gestor de máquinas virtuales de KVM esta puede ser también lanzada con 
QEMU. Para ello necesitamos hacer uso de la siguiente orden: 

`sudo qemu-system-x86_64 -boot order=c -drive file=centos.img,if=virtio`

![Ejercicio 2 - Foto 13](http://ubuntuone.com/2YPuUm1MoOq4YTl6T5N9Oc)

**2. Hacer un ejercicio equivalente usando otro hipervisor como Xen, VirtualBox o Parallels.**

Voy a utilizar VirtualBox para crear una máquina virtual de Ubuntu Server. El proceso de creación es muy parecido a como 
lo hicimos antes con el Gestor de máquinas virtuales de KVM.

Empezamos por dar nombre a la máquina que vamos a crear: 

![Ejercicio 2 - Foto 14](http://ubuntuone.com/4qf0Avw8ZRfRUDETOQDiHy)

indicamos la cantidad de memoria RAM que va a tener la máquina virtual:

![Ejercicio 2 - Foto 15](http://ubuntuone.com/3j2Oyo2ntIbUdnrzC0trpp)

elegimos crear un nuevo disco duro virtual:

![Ejercicio 2 - Foto 16](http://ubuntuone.com/1dxJZPafnvznPoMdQ6mblP)

y el tipo de disco duro virtual que va a ser:

![Ejercicio 2 - Foto 17](http://ubuntuone.com/3wj7j8GbtCeiEG4MIB7yN4)

le decimos que se cree dinámicamente:

![Ejercicio 2 - Foto 18](http://ubuntuone.com/1sUxyA35GabZe9KEuSOHmm)

y elegimos el tamaño que va a tener el disco duro virtual:

![Ejercicio 2 - Foto 19](http://ubuntuone.com/0Aa0eAL9ZtWQyPrbc2EUaf)

y ya tenemos creada la máquina virtual:

![Ejercicio 2 - Foto 20](http://ubuntuone.com/6pCKVRHRe3iAeAEhLrou5t)

Una vez que acabamos de crear la máquina virtual, solo queda instalar el Sistema Operativo:

![Ejercicio 2 - Foto 21](http://ubuntuone.com/6MXwhFVcT8ViJFq7HUWF7v)

y una vez que termine de instalarse el Sistema Operativo, tenemos nuestra máquina virtual de Ubuntu Server creada 
correctamente: 

![Ejercicio 2 - Foto 22](http://ubuntuone.com/7Mb3UvznwFp0X5GpmtiqK9)

## Ejercicio 4

**Crear una máquina virtual Linux con 512 megas de RAM y entorno gráfico LXDE a la que se pueda acceder mediante VNC y** 
**ssh.**

La máquina virtual que voy a crear va a tener como Sistema Operativo Lubuntu 12.04, ya que este Sistema Operativo trae el
entorno gráfico LXDE. 

Para crear dicha máquina virtual con QEMU debemos seguir los mismos pasos que en los ejercicios anteriores. Primeramente 
creamos el disco duro virtual que va a utilizar la máquina con la siguiente orden:

`qemu-img create -f qcow2 lubuntu.img 10G`

![Ejercicio 4 - Foto 1](http://ubuntuone.com/3dq1lV1opHoG9gxyBHPpzp)

e instalamos la máquina en dicho disco, añadiéndole la opción de que tenga 512M de RAM con la siguiente orden: 

`qemu-system-x86_64 -hda lubuntu.img -cdrom lubuntu-12.04-desktop-i386.iso -m 512M`

![Ejercicio 4 - Foto 2](http://ubuntuone.com/3kwiXyEkmTOlDYqhaLXxdZ)

Cuando termine el proceso de instalación, la arrancamos con la siguiente orden y visualizamos que se acaba de instalar 
correctamente: 

`qemu-system-x86_64 -boot order=c -drive file=lubuntu.img,if=virtio -m 512M`

![Ejercicio 4 - Foto 3](http://ubuntuone.com/3vm34eh20iT1yAXzKy7B9s)

Para conectarnos a la máquina virtual anterior utilizando el servidor VNC, necesitamos instalar en nuestra máquina 
anfitriona un cliente VNC. Para ello instalamos el siguiente paquete: 

`sudo apt-get install vinagre`

Ahora para conectarnos a la máquina virtual necesitamos conocer la dirección IP de la interfaz NAT de nuestra máquina 
para poder utilizar dicho servicio de VNC. Para ello utilizamos el comando `ifconfig` y vemos cual es la dirección IP de 
dicha interfaz que se llama `virbr0`: 

![Ejercicio 4 - Foto 4](http://ubuntuone.com/5dIKtiEoAGD8AN31sW60nB)

Una vez que sabemos la dirección IP y tenemos instalado el cliente VNC, solo queda arrancar la máquina virtual con la 
siguiente orden: 

`qemu-system-x86_64 -boot order=c -drive file=lubuntu.img,if=virtio -m 512M -vnc :1`

y conectarnos a la máquina con: 

`vinagre 192.168.122.1:5901`

![Ejercicio 4 - Foto 5](http://ubuntuone.com/38Ov0X6s2sRhrYKrYor7Ek)

Ahora para conectarnos a la máquina virtual a través de SSH, arrancamos la máquina virtual con la siguiente orden:

`qemu-system-x86_64 -boot order=c -drive file=lubuntu.img,if=virtio -m 512M -redir tcp:2222::22`

y para conectarnos a ella desde el sistema anfitrión utilizamos: 

`ssh -p 2222 jose@localhost`

## Ejercicio 5

**Crear una máquina virtual Ubuntu e instalar en ella un servidor nginx para poder acceder mediante web.**

Para crear una máquina virtual en Azure debemos saber cuales son las imágenes que tiene esta plataforma disponibles. Para
ello las listamos con la siguiente orden: 

`azure vm image list`

De todas las que nos ofrece la plataforma, voy a instalar la que se muestra a continuación resaltada:

![Ejercicio 5 - Foto 1](http://ubuntuone.com/6AbZh4IDi9PzOGMDlFhJSy)

Para saber si dicha imagen está disponible o no, utilizamos la siguiente orden para ver los detalles de dicha imagen: 

`azure vm image show b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-12_04_3-LTS-amd64-server-20131205-en-us-30GB`

![Ejercicio 5 - Foto 2](http://ubuntuone.com/7jyeez9rORN8aJbmPokO0u)

La imagen está disponible, por lo tanto podemos crear dicha máquina virtual. Para su creación utilizamos la siguiente 
orden: 

> ```
> azure vm create jcastilloprez b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-12_04_3-LTS-amd64-server-20131205-en-us-30GB 
> jose Password --location "West Europe" --ssh
> ```

![Ejercicio 5 - Foto 3](http://ubuntuone.com/3uOIVWnbzZbFnKy1GsmhXF)

Una vez que ha terminado de crearse, podemos listar todas las máquinas virtuales que tenemos creadas en Azure:

![Ejercicio 5 - Foto 4](http://ubuntuone.com/2fx1qkFYRWl7ACFO7Q6NOd)

y arrancar dicha máquina con: 

![Ejercicio 5 - Foto 5](http://ubuntuone.com/19X67cwFokTl19x1vv8wYq)

Como a la hora de la creación de la máquina hemos indicado la opción de acceso mediante SSH, vamos a conectarnos a la 
máquina mediante SSH con la siguiente orden:

`ssh jose@jcastilloprez.cloudapp.net`

![Ejercicio 5 - Foto 6](http://ubuntuone.com/2RYfI5nakIuDLw2l3hq2Tu)

Una vez que hemos accedido a la máquina, procedemos a instalar nginx en ella con la siguiente orden:

`sudo apt-get install nginx`

Una vez que termine tendremos instalado nginx en la máquina, pero no podremos acceder desde la web a la página de inicio 
del servidor. Esto es debido a que no hemos abierto los puertos del servicio HTTP en la máquina y si miramos qué puertos 
tiene abiertos la máquina podremos ver que solamente tiene abierto el del SSH que le indicamos al crear la máquina: 

![Ejercicio 5 - Foto 7](http://ubuntuone.com/5xet60RLX4NEdpprQFwZzD)

para ello abrimos dicho puerto con la siguiente orden:

`azure vm endpoint create jcastilloprez 80 80`

![Ejercicio 5 - Foto 8](http://ubuntuone.com/34TbtbIg1DNMmTX6VO12N1)

y si volvemos a listar los puertos accesibles, vemos como el puerto de HTTP aparece ya en la lista.

![Ejercicio 5 - Foto 9](http://ubuntuone.com/4gN8FHw9poY2bXCGpFW37a)

Volvemos a la máquina virtual e iniciamos el servidor nginx:

![Ejercicio 5 - Foto 10](http://ubuntuone.com/5SC9pJahx0E0KU45nFoEpE)

Ya solo queda acceder a un navegador e introducir la dirección de la máquina virtual y que este nos muestre la pagina de 
inicio de nginx.

![Ejercicio 5 - Foto 11](http://ubuntuone.com/3UrTywnPgaUuIVUrubnfji)

Cuando terminemos de usar la máquina virtual de Azure la apagamos:

![Ejercicio 5 - Foto 12](http://ubuntuone.com/2t4fQ1NB35ewM7IZ8S3LhZ)

## Ejercicio 6

**Usar juju para hacer el ejercicio anterior.**

Para utilizar juju junto con Azure necesitamos cambiar el fichero de configuración que viene con juju. Dicho fichero se 
encuentra en  **~/.juju/environments.yaml** y se genera con: 

`sudo juju generate-config`

Abrimos el fichero y debemos modificar la sección correspondiente a Azure, metiéndole nuestros propios valores a las 
siguientes variables: **management-subscription-id**, **management-certificate-path** y **storage-account-name**. 

En **management-certificate-path** debemos introducir un certificado para el uso de juju, dicho certificado lo generamos 
con las siguientes ordenes: 

> ```
> openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout azure.pem -out azure.pem
> openssl x509 -inform pem -in azure.pem -outform der -out azure.cer
> chmod 600 azure.pem
> ```

![Ejercicio 6 - Foto 1](http://ubuntuone.com/5b3MsVgy7rsMjsHEuxBF1s)

ya hemos creado el certificado, por lo tanto, queda decirle en la variable **management-certificate-path** donde se 
encuentra el archivo **azure.pem** que acabamos de crear y el archivo **azure.cer** subirlo manualmente a la página de 
Windows Azure:

![Ejercicio 6 - Foto 2](http://ubuntuone.com/4tHVWkt3jO1W4ssq65DaBf)

Para rellenar la variable **management-subscription-id**, que es el identificador de suscripción de nuestra cuenta de 
Azure, introducimos el valor del campo **Id** que nos proporciona la salida de la siguiente orden: 

`azure account list`

![Ejercicio 6 - Foto 3](http://ubuntuone.com/4QsR3YtDMxIjpDREp0qR5f)

Por último, en la variable **storage-account-name** que es el nombre de una cuenta de almacenamiento, dicha cuenta ya 
está creada de un ejercicio anterior, introducimos el valor del campo **name** que nos proporciona la salida de la 
siguiente orden:

`azure account storage list`

![Ejercicio 6 - Foto 4](http://ubuntuone.com/5KYMtjSRCW4buUbmUNkGfJ)

Por lo tanto, el fichero de configuración de juju queda tal que así: 

![Ejercicio 6 - Foto 5](http://ubuntuone.com/2H0WP59mwhVoK5YHYcSvO5)

Ya que hemos realizado la configuración, empezamos por indicarle a juju que va a usar Azure con:

`sudo juju switch azure`

una vez que termine, construimos el entorno con:

`sudo juju bootstrap`

indicamos que se va a emplear el charm `juju-gui`:

`sudo juju deploy --to 0 juju-gui`

y lo exponemos para poder usarlo:

`sudo juju expose juju-gui`
 
Una vez que termine, visualizamos el estado con: 

`sudo juju status`

![Ejercicio 6 - Foto 6](http://ubuntuone.com/1CXyR6n66h2TQQi9d02lRh)

Una vez que ha terminado de crearse, procedemos a añadirle el servidor nginx. Para ello indicamos que al entorno creado 
anteriormente le vamos a emplear el charm nginx: 

`sudo juju deploy --to 0 cs:~imbrandon/precise/nginx`

lo exponemos: 

`sudo juju expose nginx`

y mostramos el estado con:

`sudo juju status`

![Ejercicio 6 - Foto 7](http://ubuntuone.com/3CUANiYvJSP4j7nFzDZ29S)

y cuando termine podremos ver que se ha instalado correctamente. Otra manera de ver que se ha instalado correctamente es 
abrir un navegador y acceder a la dirección que nos da. Esta página nos pide que nos registremos, el usuario es 
**user-admin** y la contraseña es el valor del campo **admin-secret** que se encuentra en el fichero de configuración de 
juju. Y una vez que accedamos visualizamos la página tal y como se muestra a continuación:

![Ejercicio 6 - Foto 8](http://ubuntuone.com/4TrxnKTgGpzAKQ4NBORNt9)

en donde podemos ver que tanto nginx, como juju-gui se han instalado y funcionan correctamente. 

Ya solamente quedaría configurar nginx dentro de juju para que podamos acceder a la página inicial de nginx desde un 
navegador web. 
