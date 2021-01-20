## Unidad 5 - Actividad 2
# Docker
## 1. Contenedores con Docker
### 1.1 Instalación
* Para instalar docker en OpenSUSE, ejecutar el comando `zypper in docker`.

![](img/01.png)
* Iniciamos el servicio con el comando `systemctl start docker`. Y, si además queremos que el servicio se inicie automáticamente al encender la máquina ejecutamos `systemctl enable docker`.

![](img/02.png)
* Añadimos nuestro usuario al grupo `docker`.

![](img/03.png)
* Comprobamos que con `docker version` se muestra la información del cliente y del servidor.

![](img/04.png)

### 1.2 Habilitar el acceso a la red externa a los contenedores
* Para habilitar el acceso a la red externa, el estado de IP_FORWARD debe estar en 1 (activado). En este caso aparece activado por defecto.

![](img/05.png)

### 1.3 Primera prueba
* El comando `docker run hello-world` descarga una imagen *hello-world*, crea un contenedor, y ejecuta la aplicación que hay dentro. Al ejecutarlo, nos dice "*Unable to find image 'hello-world:lastest' locally*", por lo que descargará la imagen de internet.

![](img/06.png)
* Comprobamos que se ha descargado la imagen correctamente.

![](img/07.png)
* Ejecutando `docker ps -a` nos aparecen los contenedores que tenemos creados. Vemos que se ha creado uno desde la imagen `hello world`.

![](img/08.png)
* Con `docker stop ID-CONTENEDOR` paramos el contenedor, y con `docker rm ID-CONTENEDOR` lo eliminamos.

![](img/09.png)

### 1.4 Alias
* Podemos crear una serie de alias para ayudarnos a trabajar de forma más rápida. Para ello crearemos el fichero `/home/alvaro/.alias`.

![](img/10.png)
* Al que le añadiremos el siguiente contenido:

![](img/11.png)
* Reiniciamos la máquina para que se guarden los cambios y probamos su funcionamiento. Por ejemplo, si ejecutamos el comando `di` nos listará las imágenes que tengamos descargadas.

![](img/12.png)

---
## 2. Creación manual de nuestra imagen
### 2.1 Crear un contenedor manualmente
**Descargar una imagen**
* Podemos listar todas las imágenes del repositorio a partir de una etiquete, por ejemplo, listamos las imágenes que tengan la etiqueta `debian`.

![](img/13.png)
* Descargamos la imagen en local.

![](img/14.png)
* Y comprobamos:

![](img/15.png)

**Crear un contenedor**
* El contenedor se llamará `app1debian`, se creará a partir de la imagen `debian`, y se ejecutará el comando `/bin/bash`.

![](img/16.png)

### 2.2 Personalizar el contenedor
**Instalar aplicaciones dentro del contenedor**
* Comprobamos con `cat /etc/motd` que estamos en Debian.

![](img/17.png)
* Actualizamos los repositorios.

![](img/18.png)
* Instalamos nginx en el contenedor

![](img/19.png)
* Instalamos el editor de texto vi.

![](img/20.png)

**Crear un fichero html**
* Creamos un fichero html con el párrafo `Hola Alvaro`.

![](img/21.png)

**Crear un script**
* Creamos el fichero `server.sh` en la ruta `/root` con el siguiente contenido:

![](img/22.png)

>*Recordar que hay que darle permisos de ejecución al script*
>
>![](img/23.png)

### 2.3 Crear una imagen a partir del contenedor
* Vamos a ejecutar el comando `docker commit app1debian alvaro/nginx1` desde otra ventana de terminal para crear la imagen a partir del contenedor.

![](img/24.png)
* Comproamos que se ha creado la nueva imagen.

![](img/25.png)
* Ejecutando `docker stop app1debian` paramos el contenedor, y lo destruimos con `docjer rm app1debian`. Comprobamos que no aparece el contenedor.

![](img/26.png)

---

## 3. Crear un contenedor a partir de nuestra imagen
### 3.1 Crear contenedor con Nginx
* Vamos a iniciar un contenedor a partir de la imagen con Nginx que acabamos de crear.

![](img/27.png)

### 3.2 Comprobamos
* Con el comando `docker ps` vemos los contenedores en ejecución. Vemos que aparece una columna `PORT` que nos indica que el puerto 80 está redireccionado al puerto local 32768.

![](img/28.png)
* Abrimos un navegador web y buscamos la URL `localhost:32768`, de esta forma nos conectaremos al servidor Nginx que está en ejecución.

![](img/29.png)
* Tamién podemos comprobar el acceso a `holamundo1.html`

![](img/30.png)
* Finalmente paramos y eliminamos el contenedor.

![](img/31.png)

### 3.3 Migrar la imagen a otra máquina
**Exportar la imagen**

* Para exportar la imagen ejecutamos el comando `docker save -o alvaro21docker.tar alvaro/nginx1`, de esta manera, la imagen se guarda en un fichero tar.

![](img/32.png)

**Importar la imagen**

* Copiamos la imagen en otra máquina, en este caso usaremos la herramienta `scp`.

![](img/33.png)
* Comprobamos que se ha copiado correctamente.

![](img/34.png)
* Creamos la imagen a partir del fichero tar usando el parámetro `load`.

![](img/35.png)
* Comprobamos que la imagen se creó correctamente.

![](img/36.png)
* Finalmente, iniciamos un contenedor para comprobar su funcionamiento.

![](img/37.png)

---

## 4. Dockerfile
### 4.1 Preparar ficheros
* Creamos el directorio `docker21a`, y un fichero `holamundo2.html` con el siguiente contenido:

![](img/38.png)
* Creamos el fichero `Dockerfile` con el siguiente contenido:

![](img/39.png)

### 4.2 Crear imagen a partir del Dockerfile
* Para construir una imagen a partir de un Dockerfile basta con situarse en el directorio donde se encuentra el archivo y ejecutar `docker build -t alvaro/nginx2 .`.

![](img/40.png)
* Comprobamos que se ha creado la imagen.

![](img/41.png)

### 4.3 Crear contenedor y comprobar
* Ejecutamos `docker run --name=app4nginx2 -p 8082:80 -t alvaro/nginx2` y comprobamos que se ha iniciado correctamente.

![](img/42.png)
* Desde el navegador comprobamos con la URL `http://localhost:8082`

![](img/43.png)
* Y comprobamos el fichero `holamundo2.html` con la URL `http://:localhost:8082`.

![](img/44.png)

### 4.4 Usar imágenes ya creadas
* Vamos a crear el directorio `docker21b`, y un fichero llamado `holamundo3.html` con el siguiente contenido:

![](img/45.png)
* Creamos el siguiente Dockerfile:

![](img/46.png)
* Creamos la imagen a partir del Dockerfile.

![](img/47.png)
* Iniciamos el contenedor con la imagen creada.

![](img/48.png)
* Finalmente, comprobamos el acceso a `holamundo3.html`.

![](img/49.png)

---

## 5. Docker Hub
* Para este apartado vamos a crear una carpeta con el nombre `docker21c`. En ella crearemos un script (`holamundo21.sh`) con el siguiente contenido:

![](img/50.png)
* Creamos el fichero Dockerfile con lo siguiente:

![](img/51.png)
* Creamos la imagen a partir del fichero Dockerfile.

![](img/52.png)
* Iniciamos un contenedor a partir de la imagen.

![](img/53.png)
* Vamos a registrarnos en la página oficialde Docker Hub. Una vez registrados, ejecutamos `docker login -u USERNAME` (en mi caso, el nombre de usuario es `alvarohdr`), y ponemos la contraseña. 

![](img/54.png)
* Etiquetamos la imagen con `version1`.

![](img/55.png)
* Por último, subimos la imagen a los repositorios de Docker.

![](img/56.png)