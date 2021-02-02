## Unidad 5 - Actividad 3
# Salt-Stack
## 1. Preparartivos
* Para esta actividad utilizaremos las siguientes máquinas virtuales:

| ID  | SSOO     | IP estática   | Equipo       |
| --- | -------- | ------------- | ------------ |
| MV1 | OpenSUSE | 172.19.21.31  | master21g    |
| MV2 | OpenSUSE | 172.19.21.32  | minion21g    |
* Comprobamos la IP del Maestro:

![](img/01.png)
* Comprobamos el nombre de la máquina Maestro:

![](img/02.png)
* Comprobamos la IP del Minion:

![](img/03.png)
* Comprobamos el nombre de la máquina Minion:

![](img/04.png)

---
## 2. Master: Instalar y configurar
* Instalamos la herramienta `salt-master`.

![](img/05.png)
* Añadimos las siguientes líneas al fichero `/etc/salt/master`:

![](img/06.png)
* Activamos el servicio en el arranque del sistema con `systemctl enable salt-master.service`, e iniciamos el servicio con `systemctl start salt-master.service`.

![](img/07.png)
* Para consultar los minions aceptados por nuestro master utilizamos `salt-key -L`. Podemos observar que aún no hay ninguno.

![](img/08.png)

---

## 3. Minion
### 3.1 Instalación y configuración
* Instalamos el software del minion.

![](img/09.png)
* Añadimos la línea `master:172.19.21.31` al fichero `/etc/salt/minion`.

![](img/10.png)
* Activamos el servicio en el arranque del sistema e iniciamos el servicio.

![](img/11.png)
* comprobamos que no está instalado `apache2` en el Minion.

![](img/12.png)

### 3.2 Cortafuegos
* Desde la máquina Master consultamos la zona de red.

![](img/13.png)
* Abrimos el puerto de forma permanente en la zona "public".

![](img/14.png)
* Reiniciamos el cortafuegos para que se actualicen los cambios.

![](img/15.png)
* Comprobamos la configuración de la zona public.

![](img/16.png)

### 3.3 Aceptación desde el Master
* Si ahora ejecutamos `salt-key -L` vemos que el Master recibe la petición del Minion.

![](img/17.png)
* Acemptamos al Minion y Comprobamos.

![](img/18.png)

### 3.4 Comprobamos conectividad
* `salt '*' test.ping` para comprobar conectividad y `salt '*' test.version` para comprobar la versión de Salt instalada en el Minion.

![](img/19.png)

---

## 4. Salt States
### 4.1 Preparar el directorio para los estados
* Crear los directorios `/srv/salt/base` y `/srv/salt/devel`.

![](img/20.png)
* Crear el archivo `/etc/salt/master.d/roots.conf` con el siguiente contenido:

![](img/21.png)
* Reiniciamos el servicio.

![](img/22.png)

### 4.2 Crear un nuevo estado
* Creamos el fichero `/srv/salt/base/apache/init.sls` con el siguiente contenido:

![](img/28.png)

### 4.3 Asociar Minions a estados
* Crear el fichero `/srv/salt/base/top.sls` donde asociaremos el estado que acabamos de crear a nuestro minion.

![](img/24.png)

### 4.4 Comprobar: estados definidos
* Consultamos los estados que tenemos definidos para cada minion.

![](img/25.png)

### 4.5 Aplicar el nuevo estado
**En el Master:**
* Consultamos los estados en detalle para verificar que no hay errores en las definiciones:

![](img/26.png)

![](img/27.png)
* Aplicamos el nuevo estado en todos los Minions.

![](img/29.png)
* Comprobamos que se ha instalado e iniciado el servicio `Apache2`.

![](img/30.png)

---

## 5. Crear más estados
### 5.1 Crear estado "users"
* Creamos el directorio `/srv/salt/base/users`, y el archivo `init.sls` con el siguiente contenido.

![](img/31.png)
* Aplicamos el estado.

![](img/32.png)
* Comprobamos que se ha creado el grupo y los usuarios en el Minion.

![](img/33.png)

### 5.2 Crear estado "archivos"
* Creamos el estado `archivos`. Dentro del estado, crearemos el archivo `init.sls` con el siguiente contenido:

![](img/34.png)
* Aplicamos el estado.

![](img/35.png)
* Comprobamos que se han creado los directorios con los permisos deseados en el Minion.

![](img/36.png)

### 5.3 Ampliar estado "apache"
* Creamos el fichero `/srv/salt/base/files/holamundo.html`

![](img/37.png)
* Incluimos la creación del fichero `holamundo.html` en el estado `apache`.

![](img/39.png)
* Aplicamos el estado.

![](img/40.png)
* Comprobamos que se ha creado el archivo `holamundo.html` en el Minion.

![](img/41.png)
* Finalmente, comprobamos que tenemos acceso al archivo a través de apache.

![](img/42.png)