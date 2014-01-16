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
