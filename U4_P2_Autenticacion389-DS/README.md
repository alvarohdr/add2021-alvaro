## Unidad 4 - Actividad 2
# Cliente para autenticación LDAP
## 1. Preparativos
Antes de empezar vamos a comprobar el acceso al servidor LDAP desde el cliente:
* Para ver si los puertos de LDAP están abiertos y son accesibles desde el cliente, ejecutaremos el comando `nmap -Pn server21g | grep -P '389|636'`.

![](img/01.png)

* Con `ldapsearch -H ldap://server21g:389 -W -D "cn=Directory Manager" -b "dc=ldap21,dc=curso2021" "(uid=*)" | grep dn` podemos ver los usuarios de LDAP son visibles desde el cliente.

![](img/02.png)

* Vemos que aparecen varios usuarios como `mazinger`,

![](img/03.png)

* O `koji`.

![](img/04.png)

---
## 2. Crear autenticación LDAP
### 2.1 Crear conexión con el Servidor
* Vamos a `Yast -> Cliente LDAP y Kerberos`.
* Comprobamos que el nombre del equipo es correcto.

![](img/05.png)

* Le damos a `Cambiar configuración` y lo configuramos de la siguiente manera:

![](img/06.png)

* Probamos la conexión y vemos que entra correctamente

![](img/07.png)

### 2.2 Comprobar con Comandos
Vamos a la consola con usuario root y ejecutamos lo siguiente:
* Con `id mazinger` vemos la configuración del usuario `mazinger`
* Para poder utilizar el usuario haremos `su -l mazinger`, con el atributo `-l` no nos pedirá la contraseña y, al ser la primera vez que entramos al usuario, creará el directorio home del usuario.

![](img/08.png)

* `gatent passwd mazinger` muestra más información del usuario.
* Con `cat /etc/passwd | grep mazinger` no nos aparece nada porque no es un usuario local.

![](img/09.png)

---

## 3. Crear usuarios y grupos dentro de LDAP
* Iremos a `Yast -> Gestión de usuarios y grupos`. En la pestaña `Definir filtro` encontraremos la opción `LDAP users`, que nos pedirá el usuario LDAP y la contraseña.

![](img/10.png)

* *NOTA:En este paso aparece el siguiente error y no nos permite continuar:*

![](img/11.png)
