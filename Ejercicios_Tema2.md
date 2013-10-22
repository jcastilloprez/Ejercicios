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
