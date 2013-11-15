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
