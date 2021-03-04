## Unidad 7 - Actividad 2
# Bot-service
## 1. Crear un bot de Telegram con Ruby
* Scrpit del bot:

![](img/07.png)

* Vídeo de YouTube donde se muestra el funcionamiento del bot: https://www.youtube.com/watch?v=LbcQnZ_psfU

---
## 2. Systemd
* Fichero de configuración del servicio:

![](img/08.png)

* Comprobamos que el servicio está activo y el bot está en funcionamiento.

![](img/01.png)

* Paramos el servicio y comprobamos que ahora no funcionan los comandos del bot.

![](img/02.png)

---

## 3. Programar tareas
* Fichero que consulta si el servicio está activo o inactivo. En el caso de estar inactivo, lo inicia. Además, cada vez que se ejecute envía un mensaje al fichero `/etc/bot21/log`.

![](img/03.png)

* Creamos la siguiente tarea con la herramienta crontab:

![](img/04.png)

* Paramos el servicio, esperamos 5 minutos, y vemos que el servicio se activa automáticamente.

![](img/05.png)

* Si observamos el contenido del fichero `cat /etc/bot21/log`, vemos que se ha guardado las acciones realizadas.

![](img/06.png)