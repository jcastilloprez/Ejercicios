# Ejercicios del 25-11-2013

## Ejercicio 1

**Instalar Ruby y usar ruby --version para comprobar la versión instalada. A la vez, conviene instalar también irb,** 
**rubygems y rdoc.**

Empezamos instalando Ruby con: 

`sudo apt-get install ruby`

Una vez terminada la instalación, comprobamos la versión de Ruby que tenemos instalada con: 

`ruby --version` 

![Ejercicio 1](http://ubuntuone.com/75vIUdq9GLjPZHvm2xr279)

Ahora instalamos **irb**, **rubygems**, y **rdoc** con:

`sudo apt-get install irb rubygems rdoc`

## Ejercicio 2

**Crear un programa en Ruby que imprima los números desde el 1 hasta otro contenido en una variable.**

Antes de ponernos a hacer el primer programa con Ruby, sería conveniente mirar donde se encuentra el interprete de Ruby 
con:

`which ruby` 

![Ejercicio 2 - Foto 1](http://ubuntuone.com/3u5fr89svQK42Nj68nk2a8)

Una vez que sabemos en donde se encuentra el interprete, procedemos a crear nuestro primer programa con Ruby:

![Ejercicio 2 - Foto 2](http://ubuntuone.com/0AWRoGkl5CInHONIhLS7mf)

Una vez que hagamos el programa y lo guardemos, le damos permisos de ejecución con:

`chmod +x ejercicio2.rb`

y lo lanzamos:

![Ejercicio 2 - Foto 3](http://ubuntuone.com/5YZj8A3yy6KnpzXCpozoyR)

## Ejercicio 3

**¿Se pueden crear estructuras de datos mixtas en Ruby? Crear un array de hashes de arrays e imprimirlo.**

Sí, se pueden crear estructuras de datos mixtas en Ruby y es muy fácil. Un ejemplo de esto es el siguiente programa:

![Ejercicio 3 - Foto 1](http://ubuntuone.com/56Ycm69HCZ0VTj7B2zqWlY)

y su salida es la siguiente:

![Ejercicio 3 - Foto 2](http://ubuntuone.com/32xhYgovr7RXqXPpkgpmwr)

## Ejercicio 4

**Crear una serie de funciones instanciadas con un URL que devuelvan algún tipo de información sobre el mismo: fecha** 
**de última modificación, por ejemplo.** 

Para leer la información de una página web cualquiera, tenemos que utilizar la librería **Net::HTTP**, así que lo 
primero que tenemos que hacer en nuestro programa es importarla con `require 'net/http'`. Una vez importada la librería,
utilizamos el método `Net::HTTP.get_response(ARGV[0], '/')` para enviar una petición **GET** a la página web pasada como
argumento desde la línea de comandos. 

De todos los campos de la cabecera HTTP de respuesta, he conseguido obtener la salida de la fecha de envío de la 
petición, el tipo MIME del contenido y el servidor que utiliza el sitio web. 

Con todo esto mi programa es el siguiente: 

![Ejercicio 4 - Foto 1](http://ubuntuone.com/4jGd6dX2CI8FDDUez3i7gZ)

y su salida es la siguiente: 

![Ejercicio 4 - Foto 2](http://ubuntuone.com/5yIUWhxY6uMkD41YENSNns)

## Ejercicio 5

**Ver si está disponible Vagrant como una gema de Ruby e instalarla.**

Para comprobar que está disponible **Vagrant** como gema de Ruby, la buscamos en la colección remota de gemas que tiene 
Ruby. Para ello utilizamos la siguiente orden:

`gem search --remote vagrant` 

Localizamos la gema en el listado que nos aparece y la instalamos con:

`sudo gem install vagrant` 
