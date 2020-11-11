## Unidad 3 - Actividad 1
# Servidor de impresión en Windows
## 1. Impresora compartida
### 1.1 Rol impresión
- En el servidor, instalar rol/función de servicios de impresión.

![](img/01.png)

- Incluir Impresión en Internet.

![](img/02.png)

### 1.2 Instalar impresora PDF
- Descargar la herramienta `PDFCreator`.

![](img/03.png)

- Configurar en `Perfiles -> Guardar`.

![](img/04.png)

- Configurar el guardado automático e indicar la carpeta de destino.

![](img/05.png)

### 1.3 Probar impresión en local
- Para probar la impresión local crearemos un archivo `imprimir21s-local`.

![](img/06.png)

- Imprimir el documento seleccionando `PDFCreator` como impresora.

![](img/07.png)

- Vemos que aparece el archivo pdf en la carpeta de destino que indicamos anteriormente.

![](img/08.png)

---
## 2. Compartir por red
### 2.1 En el servidor
- Ir a `Administrador de impresión -> Impresoras -> PDFCreator -> Compartir` y cambiar el nombre del recurso compartido por `PDFalvaro21`. 

![](img/09.png)

### 2.2 Comprobar desde el cliente
- Buscar recursos de red en el servidor con `\\172.19.21.11` en la barra de navegación.

![](img/10.png)

- Seleccionar la impresora y pulsar la opción `Conectar`.

![](img/11.png)

- Para imprimir desde remoto seguimos los mismos pasos que en local. Cremos un documento `imprimir21w-remoto`.

![](img/12.png)

- Le damos a imprimir y seleccionamos la impresora `PDFCreator`.

![](img/13.png)

- Si volvemos a la carpeta de destino del servidor, observamos que aparece el nuevo pdf.

![](img/14.png)

---
## 3. Acceso Web
### 3.1 Instalar característica Impresión WEB
- Vamos al servidor
- Comprobamos que está instalado el servicio `Impresión de Internet`.

### 3.2 Configurar impresión WEB
- Abrir navegador web y poner la URL `http://172.19.21.11/printers`. Aparecerá una ventana para autentificarte como uno de los usuarios habilitados (por ejemplo "Administrador").

![](img/16.png)

- Vemos que nos aparecen todas las impresoras disponibles.

![](img/17.png)

- Entramos en la pestaña `Propiedades` y apuntamos el nombre de la red.

![](img/18.png)

- Agregamos una nueva impresora de red.

![](img/19.png)

- En la opción `seleccionar una impresora` ponemos el nombre que copiamos en la pestaña de propiedades. 

![](img/20.png)

- Indicamos el usuario y la contraseña, usuario Administrador en este caso.

![](img/21.png)

- Y nos saldrá un mensaje indicando que la impresora se agregó correctamente.

![](img/22.png)

### 3.3 Comprobar desde el navegador
- Para probar desde el navegador vamos a empezar por poner la impresora en pausa desde el servidor.

![](img/23.png)

- Entonces crearemos un archivo `imprimir21w-Web`, le damos a imprimir y seleccionamos la impresora en `http://172.19.21.11`.

![](img/24.png)

- Al estar la impresora en pausa nos aparece el archivo en la cola. Le damos a reanudar.

![](img/25.png)

- Y ya nos aparece el archivo pdf en la carpeta destino del servidor.

![](img/26.png)