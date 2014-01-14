# Ejercicios del 20-13-2013

## Ejercicio 1

**Instalar los paquetes necesarios para usar KVM. Se pueden seguir estas instrucciones. Ya lo hicimos en el primer tema,**
**pero volver a comprobar si nuestro sistema está preparado para ejecutarlo o hay que conformarse con la** 
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
