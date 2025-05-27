# Proyecto: Nagios Core en Docker

Este proyecto proporciona una imagen Docker personalizada que instala y configura Nagios Core usando una instancia AWS EC2 con Ubuntu 20.04 como sistema operativo base. Permite que cualquier persona con conocimientos básicos de Docker pueda desplegar un contenedor Nagios completamente funcional, listo para monitorear servicios y servidores desde una interfaz web.

---

## Requisitos previos

Antes de comenzar, se necesita lo siguiente:
- Docker instalado en la máquina huésped.
- Git instalado para clonar el repositorio en la máquina huésped.
- Acceso a internet para descargar imágenes y paquetes.

---

## Contenido del repositorio

Este repositorio contiene:
- **Dockerfile** → Archivo con instrucciones para construir la imagen.
- **start.sh** → Un script que inicia Apache y Nagios dentro del contenedor.
- **README.md** → Un documento explicativo de instalación y uso.

---

## ¿Qué hace el archivo Dockerfile?

El archivo `Dockerfile` realiza los siguientes pasos:
1. Usa `FROM ubuntu:20.04` como imagen base.
2. Configura el entorno no interactivo con `ENV DEBIAN_FRONTEND=noninteractive`.
3. Instala las dependencias esenciales que contiene:
4. Crea el usuario `nagios` y ajusta los permisos de grupo para Apache.
5. Descarga y compila Nagios Core 4.4.6 desde el código fuente.
6. Configura el acceso web creando el usuario `nagiosadmin` (contraseña `nagiosadmin`).
7. Habilita el módulo CGI de Apache.
8. Expone el puerto 80 para acceso HTTP.
9. Copia el script `start.sh` y lo configura como comando principal al iniciar el contenedor.

---

## Pasos para ejecutar el proyecto

### Clonar el repositorio

```bash
git clone git@github.com:joyarzunv/Eva2_Jose_Oyarzun_1.git
cd Eva2_Jose_Oyarzun_1

---

## Construcción detallada de la imagen Docker

Cuando ejecutas:
```bash
sudo docker build -t nagios-core-image .

```bash
# Paso 2: Construir la imagen Docker

# Ejecuta el siguiente comando:
sudo docker build -t nagios-core-image .

# Este comando realiza lo siguiente:
# - Lee el Dockerfile presente en el directorio.
# - Usa la base ubuntu:20.04.
# - Configura el entorno para evitar interacciones manuales (DEBIAN_FRONTEND=noninteractive).
# - Instala paquetes necesarios: Apache, PHP, herramientas de compilación, librerías gráficas, SSL, wget, curl.
# - Crea el usuario nagios y configura permisos para Apache.
# - Descarga Nagios Core 4.4.6 desde el sitio oficial.
# - Descomprime, configura, compila e instala Nagios y su configuración web.
# - Configura el usuario web nagiosadmin con contraseña nagiosadmin.
# - Habilita el módulo CGI en Apache.
# - Copia el script start.sh que arranca los servicios cuando el contenedor corre.
# - Declara el puerto 80 como expuesto para permitir el acceso HTTP.
# Al finalizar, tendrás una imagen llamada nagios-core-image.

# Paso 3: Ejecutar el contenedor Nagios

# Ahora lanza el contenedor:
sudo docker run -d -p 80:80 --name nagios-core-container nagios-core-image

# Este comando:
# - Ejecuta el contenedor en segundo plano (-d).
# - Mapea el puerto 80 del contenedor al puerto 80 del host (-p 80:80).
# - Asigna el nombre nagios-core-container al contenedor.
# - Usa la imagen nagios-core-image creada en el paso anterior.
# Cuando el contenedor arranca, el script start.sh interno se encarga de iniciar Apache y Nagios automáticamente.

# Paso 4: Acceder a la interfaz web

# Abre tu navegador y entra a:
# http://<TU-IP-PÚBLICA>/nagios
# Si estás trabajando localmente:
# http://localhost/nagios
# Cuando aparezca el cuadro de autenticación, ingresa:
# Usuario: nagiosadmin
# Contraseña: nagiosadmin
# Si todo ha funcionado correctamente, verás la interfaz web de Nagios Core lista para monitorear servicios.

# Comandos útiles adicionales

# Si necesitas administrar el contenedor:

# Detener:
sudo docker stop nagios-core-container

# Arrancar nuevamente:
sudo docker start nagios-core-container

# Ver logs:
sudo docker logs nagios-core-container

# Entrar al contenedor:
sudo docker exec -it nagios-core-container bash

# Notas finales
# Este proyecto está diseñado para aprendizaje y pruebas.
# Si lo usas en entornos productivos:
# - Cambia las credenciales por defecto.
# - Configura volúmenes para almacenar datos de forma persistente.
# - Aplica restricciones de red para limitar el acceso externo.
