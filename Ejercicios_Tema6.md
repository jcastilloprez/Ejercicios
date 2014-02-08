# Ejercicios del 13-01-2014

## Ejercicio 1

**Instalar chef en la máquina virtual que vayamos a usar.**

Para instalar **chef** de una manera rápida y sencilla podemos hacer uso del siguiente script:

`curl -L https://www.opscode.com/chef/install.sh | sudo bash`

![Ejercicio 1](http://ubuntuone.com/5iQQed20cSq2v1ml2R2Hb2)

## Ejercicio 2

**Crear una receta para instalar nginx, tu editor favorito y algún directorio y fichero que uses de forma habitual.**

Empezamos por crear la estructura de carpetas que utiliza chef para cada una de las recetas. Por lo tanto, lo creamos 
con:

`mkdir -p chef/cookbooks/receta/recipes`

Una vez que hemos creado la estructura, nos dirigimos al último nivel, que es recipes, y creamos un archivo llamado 
default.rb que va a contener el contenido de nuestra receta: 

![Ejercicio 2 - Foto 1](http://ubuntuone.com/77aSUjoEySJs3jdiWusa1d)

Una vez que hemos creado la receta, subimos hasta el nivel chef y creamos en él el archivo node.json que se va a encargar
de hacer la referencia a la receta que hemos creado anteriormente. 

![Ejercicio 2 - Foto 2](http://ubuntuone.com/17ZAhGnu6PmfKdphQsTuLH)

También creamos el fichero solo.rb, que es el fichero de configuración de chef, que se encargar de indicar el directorio 
en el cual se encuentran las recetas y al fichero anterior, que es el fichero que se encargar de ejecutarlas. 

![Ejercicio 2 - Foto 3](http://ubuntuone.com/6gH9QSeVjpXHUY1meN9Wso)

Y una vez que hemos terminado de crear correctamente toda la configuración de chef, lo lanzamos con la siguiente orden: 

`sudo chef-solo -c chef/solo.rb`

![Ejercicio 2 - Foto 4](http://ubuntuone.com/3LbqgtnrkVnziqM6Xb4yi1)

Por último, nos queda comprobar que la receta no ha fallado y nos ha instalado y creado todo lo que le hemos pedido 
correctamente: 

![Ejercicio 2 - Foto 5](http://ubuntuone.com/6yIli1xZqyEDTRRi6YR5Wv)

## Ejercicio 3

**Escribir en YAML la siguiente estructura de datos en JSON.**

`{ uno: "dos", tres: [ 4, 5, "Seis", { siete: 8, nueve: [ 10, 11 ] } ] }`

En YAML sería de la siguiente manera: 

> ```
> ---
> - uno: "dos"
>   tres:
>     - 4
>     - 5
>     - "Seis"
>     -
>       - siete: 8
>         nueve: 
>           - 10
>           - 11
> ```

# Ejercicios del 20-01-2014

## Ejercicio 4

**Desplegar los fuentes de la aplicación de DAI o cualquier otra aplicación que se encuentre en un servidor git público**
**en la máquina virtual Azure (o una máquina virtual local) usando ansible.**

Empezamos por instalar en la máquina anfitriona Ansible, para ello primero debemos añadir su repositorio con la siguiente
orden:

`sudo add-apt-repository ppa:rquillo/ansible`

![Ejercicio 4 - Foto 1](http://ubuntuone.com/65YblIy7pdAUWisHijGZzm)

Actualizamos los repositorios con:

`sudo apt-get update`

e instalamos Ansible:

`sudo apt-get install ansible`

Cuando termine la instalación y antes de poder usar Ansible, debemos de crear un fichero con el inventario de todas las 
máquinas que va a controlar la máquina anfitriona. Dicho archivo se va a llamar **ansible_hosts** y lo rellenamos tal y 
como se muestra a continuación:

![Ejercicio 4 - Foto 2](http://ubuntuone.com/0KbgVdRYzhNdW44dORak6h)

Como este archivo que acabamos de crear no se encuentra en la ruta por defecto que utiliza Ansible, debemos de 
indicárselo cambiando el valor de la variable **ANSIBLE_HOSTS**. Una vez que le indiquemos el nuevo camino ya podemos 
hacer un ping a la máquina virtual de Azure y vemos que nos podemos conectar a ella a través de Ansible.

![Ejercicio 4 - Foto 3](http://ubuntuone.com/4mIzkWd1r3Vpn8YD0wNKyf)

Para poder desplegar nuestra aplicación de DAI que se encuentra en un repositorio de GitHub, debemos de tener instalado 
el módulo de git en nuestra máquina virtual de Azure. Así que lo instalamos con la siguiente orden:

`sudo apt-get install git`

Cuando se instale ya podemos volver a la máquina anfitriona y usando Ansible desplegar nuestra aplicación de DAI 
utilizando para ello la siguiente orden: 

`ansible azure -m git --ask-pass -u jose -a “repo=https://github.com/jcastilloprez/DAI.git dest=~/DAI version=HEAD”`

![Ejercicio 4 - Foto 4](http://ubuntuone.com/23sTkc3XUMv7InUEr9SlHs)

Cuando termine, solo nos queda volver a la máquina virtual de Azure y comprobar que nuestra aplicación de DAI se ha 
desplegado correctamente:

![Ejercicio 4 - Foto 5](http://ubuntuone.com/1wQjWACBMFh4ZBwsvXevIM)

## Ejercicio 5

**1. Desplegar la aplicación de DAI con todos los módulos necesarios usando un playbook de Ansible.**

Una vez que hemos realizado el ejercicio anterior y tenemos los fuentes de la aplicación de DAI desplegados en nuestra 
máquina virtual, queda lanzar dicha aplicación. Para ello vamos a hacer uso de un playbook de Ansible, dicho playbook es 
un fichero en YAML que le indica a la máquina virtual que es lo que necesita instalar para lanzar dicha aplicación. 

Por lo tanto, creamos un playbook llamado **dai.yml** y lo rellenamos tal y como se muestra a continuación: 

![Ejercicio 5 - Foto 1](http://ubuntuone.com/6zAmKQnpwZFcQSssLPlYjM)

Una vez que se ha creado el playbook queda lanzarlo, para ello utilizamos la siguiente orden: 

`ansible-playbook dai.yml --ask-pass -u jose`

![Ejercicio 5 - Foto 2](http://ubuntuone.com/78atF7l5it82dHQSQdHetp)

Una vez que termine el proceso, podemos abrir un navegador y visualizar la aplicación que acabamos de lanzar: 

![Ejercicio 5 - Foto 3](http://ubuntuone.com/2iiy5kT8vxDbaODgx6ml3q)

## Ejercicio 6

**Instalar una máquina virtual Debian usando Vagrant y conectar con ella.**

Antes de nada, debemos de instalar Vagrant para poder utilizarlo. Para ello lo instalamos con la siguiente orden: 

`sudo apt-get install vagrant`

o como una gema de Ruby con:

`sudo gem install vagrant`

Una vez que lo instalemos, accedemos a la página de [Vagrant](http://www.vagrantbox.es/) que dispone de un gran listado 
de máquinas configuradas para Vagrant e instalamos una de Debian. Para ello nos la descargamos con la siguiente orden: 

`vagrant box add squeeze http://mathie-vagrant-boxes.s3.amazonaws.com/debian_squeeze_32.box`

![Ejercicio 6 - Foto 1](http://ubuntuone.com/4iK8BLANzIFYI4TPdJcojd)

Cuando termine de descargarse, la inicializamos con:

`vagrant init squeeze`

![Ejercicio 6 - Foto 2](http://ubuntuone.com/4V2P6JKv7yNzIH493dzCYe)

Con esta ultima orden, acabamos de crear en el directorio actual un fichero llamado **Vagrantfile** que va a ser 
utilizado para configurar la máquina que acabamos de crear. 

![Ejercicio 6 - Foto 3](http://ubuntuone.com/1xK74lmtxLl5ydMLTNYGpn)

Ya que la hemos descargado, inicializado y visualizado el fichero de configuración de dicha máquina, la arrancamos con: 

`vagrant up`

![Ejercicio 6 - Foto 4](http://ubuntuone.com/6nO3PKIJteRrfhhaFmElEg)

y nos conectamos a ella con:

`vagrant ssh`

![Ejercicio 6 - Foto 5](http://ubuntuone.com/6b6nvmMz81TuONdkY4LWWb)

# Ejercicios del 24-01-2014

## Ejercicio 7

**Crear un script para provisionar Nginx o cualquier otro servidor web que pueda ser útil para alguna otra práctica.**

Voy a utilizar chef para realizar el provisionamiento de Nginx en Vagrant, para ello configuramos chef tal y como vimos 
en un ejercicio anterior. Una vez que configuremos chef, procedemos a modificar el fichero de configuración de Vagrant y 
rellenarlo tal y como se muestra a continuación:

![Ejercicio 7 - Foto 1](http://ubuntuone.com/6ayn5tY9jwQIdzoja4bZfS)

y provisionamos dicha máquina con:

`vagrant provision`

![Ejercicio 7 - Foto 2](http://ubuntuone.com/5BY49f0e39KDFSDoa1xPDt)

## Ejercicio 8

**Configurar tu máquina virtual usando Vagrant con el provisionador Ansible.**

Para empezar, debemos irnos al fichero **ansible_hosts** e indicar en dicho fichero la dirección IP de nuestra máquina. 

![Ejercicio 8 - Foto 1](http://ubuntuone.com/1nY9Ly1bu89xYiOqETZ01y)

e indicarle a Ansible que utilice dicho fichero con: 

`export ANSIBLE_HOSTS=~/ansible_hosts`

El siguiente paso es crearnos el playbook que utiliza Ansible para que nos instale en dicha máquina el servidor Nginx con
el siguiente contenido: 

![Ejercicio 8 - Foto 2](http://ubuntuone.com/0kOjZZhfIphBQhAkPrwgoD)

Una vez que hemos creado el playbook, queda acceder al fichero **Vagrantfile** e insertar la dirección IP que antes hemos
indicado y que utilice como provisionador Ansible y que instale Nginx utilizando el playbook creado anteriormente. Por 
tanto, el fichero queda tal que así:

![Ejercicio 8 - Foto 3](http://ubuntuone.com/7bK0cEn3sC4dwDjj44pkmq)

ya solo nos queda provisionar dicha máquina con:

`vagrant provision`

![Ejercicio 8 - Foto 4](http://ubuntuone.com/08r4wEMW9yw4vr7YAqj5cp)

y si accedemos a un navegador con la dirección IP de la máquina virtual, veremos que se ha instalado correctamente el 
servidor Nginx. 

![Ejercicio 8 - Foto 5](http://ubuntuone.com/25mffA5Oykvx2pZMB8BbN0)
