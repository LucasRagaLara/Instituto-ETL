# Documentación del Proyecto INSTITUTO

Este proyecto contiene una arquitectura basada en contenedores Docker que integra Apache NiFi, MySQL y MongoDB. El objetivo es procesar datos educativos y generar visualizaciones mediante Power BI. A continuación se describen los pasos necesarios para la configuración y ejecución del entorno.

## PASO 1 - Docker

### Servicios incluidos en el `docker-compose.yml`

- Apache NiFi  
- MySQL  
- MongoDB  
- (Opcional) Kafka

### Preparación

1. Asegúrese de que el archivo `mysql-connector-j-8.0.31.jar` se encuentra en la ruta:

   C:\Users\<nombre-usuario>\Documents\Docker\

2. Asegúrese de que existe la siguiente estructura de carpetas dentro de la ruta anterior:

   C:\Users\<nombre-usuario>\Documents\Docker\Data\

   Dentro de `Data` deben existir las siguientes subcarpetas:

   - `nifi`
   - `mysql`
   - `mongo`

   Estas carpetas serán utilizadas como volúmenes para almacenar datos persistentes de los servicios respectivos.

3. Desde esa misma carpeta, ejecutar:

   docker compose up -d  
   docker compose ps

Esto levantará todos los servicios definidos en el archivo `docker-compose.yml`.

## PASO 2 - MySQL

### Archivos necesarios

Asegúrese de que los siguientes archivos están presentes en la ruta:

C:\Users\<nombre-usuario>\Documents\Docker\

- `mysql-connector-j-8.0.31.jar`
- `tablas_instituto.sql`

### Ejecutar el script SQL dentro del contenedor

1. Copiar el archivo `.sql` dentro del contenedor:

   docker cp "C:\Users\<nombre-usuario>\Documents\Docker\tablas_instituto.sql" etl-mysql:/tmp/script.sql

2. Ejecutar el script:

   docker exec -i etl-mysql mysql -u root -pQwe_1234 < /tmp/script.sql

### Parámetros de conexión para NiFi

- Base de datos: `instituto`
- Puerto: `3307`
- Usuario: `root`
- Contraseña: `Qwe_1234`

## PASO 3 - NiFi

### Estructura de carpetas esperada

Las rutas base para los datos que procesará el flujo de NiFi deben estar en:

C:\Users\<nombre-usuario>\Documents\Docker\Data\NiFi\in\

### Carpetas necesarias

- `Datos_XXXX` (por ejemplo, `Datos_2020`)
- `Indicadores`

### Consideraciones importantes

- Las carpetas deben estar correctamente nombradas o el flujo fallará.
- Las tablas deben estar creadas previamente (ejecutar el SQL).
- Asegúrese de que los controladores y procesadores estén correctamente habilitados y configurados.
- Para la conexión con MySQL, revise el controlador `DBCPConnectionPoolInstituto`.
- Se recomienda ejecutar el flujo de manera progresiva en lugar de ejecutar todos los pasos a la vez.

## PASO 4 - Power BI

### Requisitos previos

- Power BI Desktop instalado
- Archivo `informe_instituto.pbix`
- MySQL ODBC Driver (versión 8.x o 5.3 si se usa MySQL 5.6)
- Contenedor de MySQL corriendo en Docker
- Puerto correctamente expuesto (ej. `3307:3306`)
- Usuario y contraseña de MySQL: `root / Qwe_1234`

### Paso 1 – Verificar accesibilidad del servidor MySQL

Comprobar que es posible conectar a:

- Host: `localhost`
- Puerto: `3307`

### Paso 2 – Instalar el controlador ODBC

Descargar desde:

https://dev.mysql.com/downloads/connector/odbc/

Instalar la versión que corresponda con la arquitectura de Power BI (32 o 64 bits).

### Paso 3 – Configurar una conexión ODBC en Windows

1. Abrir el "Administrador de orígenes de datos ODBC".
2. Ir a la pestaña DSN de sistema y hacer clic en Agregar.
3. Seleccionar MySQL ODBC 8.x Unicode Driver.
4. Configurar con los siguientes datos:

   - Data Source Name: mysql_docker
   - Server: localhost
   - Port: 3307
   - User: root
   - Password: Qwe_1234
   - Database (opcional): instituto

5. Hacer clic en Test para comprobar la conexión.

### Paso 4 – Conectar desde Power BI

1. Abrir Power BI Desktop.
2. Ir a Inicio > Obtener datos > Más...
3. Seleccionar ODBC y luego el origen mysql_docker.
4. Si no aparece, usar la opción DSN Avanzado y completar los datos manualmente.
5. Seleccionar la base de datos instituto y las tablas necesarias.
6. Pulsar Cargar o Transformar datos si es necesario aplicar filtros.

### Notas adicionales

- Si se utiliza otro puerto, actualizarlo en la configuración.
- Verificar que el contenedor etl-mysql esté en ejecución (`docker ps`).
- En Docker no es necesario modificar bind-address para permitir conexiones locales.
