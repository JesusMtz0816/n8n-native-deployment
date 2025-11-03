#Conficuración del Servidor y Firewall
# Actualizar el sistema y librerías
apt update
apt upgrade -y

# Configurar Firewall UFW
ufw allow ssh     # Acceso administrativo
ufw allow http    # Tráfico web HTTP (puerto 80)
ufw allow https   # Tráfico web HTTPS (puerto 443)
ufw enable
====================================================

#Instalación de Dependencias
# 1. Desinstalar versiones previas de Node.js (necesario si ya existía una versión conflictiva)
apt purge nodejs -y
apt autoremove -y

# 2. Instalar el Repositorio Oficial de NodeSource (v20.x LTS)
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

# 3. Instalar Node.js, npm, PostgreSQL y librerías
apt install postgresql postgresql-contrib nodejs npm -y
===================================================

#Creación de Usuario y Bd
# 1. Cambiar al usuario postgres para administrar la BD
sudo -i -u postgres

# 2. Crear el usuario (requiere ingresar la Contraseña de la BD/Clave A)
createuser --pwprompt n8n_user

# 3. Crear la base de datos
createdb -O n8n_user n8n_database

# 4. Salir de la sesión de postgres
exit
==================================================

#Asignación de permisos y extensiones Bd

sudo -i -u postgres

# 1. Instalar la extensión de similitud (pg_trgm)
psql -d n8n_database -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"

# 2. Transferir la propiedad del esquema público y otorgar permisos
psql -d n8n_database -c "GRANT USAGE ON SCHEMA public TO n8n_user;"
psql -d n8n_database -c "GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO n8n_user;"
psql -d n8n_database -c "ALTER SCHEMA public OWNER TO n8n_user;"

# 3. Otorgar permisos de acceso en todas las tablas existentes
psql -d n8n_database -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO n8n_user;"

# 4. Establecer permisos por defecto para objetos futuros
psql -d n8n_database -c "ALTER DEFAULT PRIVILEGES FOR USER n8n_user IN SCHEMA public GRANT ALL ON TABLES TO n8n_user;"
psql -d n8n_database -c "ALTER DEFAULT PRIVILEGES FOR USER n8n_user IN SCHEMA public GRANT ALL ON SEQUENCES TO n8n_user;"

exit
=================================================

#Instalación de N8N y creación de archivo .env
# 1. Instalar n8n globalmente
npm install n8n -g

# 2. Crear el directorio de datos (si no existe)
mkdir -p /home/n8n_data

# 3. Crear el archivo .env con todas las variables críticas
nano /home/n8n_data/.env
# (Asegurar que DB_POSTGRESDB_HOST=127.0.0.1 y que las claves A y B estén correctas)
=================================================

#Configuración de Systemd
#Para resolver el problema de que el binario de n8n no lee el .env (causando el error 502), 
#se implementó un script de wrapper que fuerza la carga de variables.

#Crear el script wrapper
nano /usr/local/bin/n8n-start-wrapper.sh

# (Script que carga el .env y ejecuta n8n start)
chmod +x /usr/local/bin/n8n-start-wrapper.sh

#Crear archivo de servicio
nano /etc/systemd/system/n8n.service
# (Se configura para usar el WorkingDirectory correcto y apuntar al wrapper)
#Contenido de dicho archivo

#[Unit]
Description=n8n Workflow Automation
After=network.target postgresql.service

#[Service]
# WorkingDirectory fuerza a Systemd a buscar el .env y correr el binario desde esta ruta
WorkingDirectory=/home/n8n_data

# ExecStart llama al script wrapper que cargará el .env
ExecStart=/usr/local/bin/n8n-start-wrapper.sh

Restart=always
User=root
Group=root
Type=simple

#[Install]
WantedBy=multi-user.target
===================================================

#Habilitar y verificar
systemctl daemon-reload
systemctl enable n8n.service
systemctl restart n8n.service
===================================================

#Inicialización de la Bd (Script Sql)
# Comando de Creación (Pegar Script de la Bd)
nano /tmp/init_db.sql

#Ejecución del Script
# Se movió el archivo a /tmp/ y se ejecutó para evitar errores de permisos de Linux
sudo -i -u postgres psql -d n8n_database -f /tmp/init_db.sql

===================================================

#Configuración del proxy con Nginx
#1. Crear el archivo de configuración del dominio
nano /etc/nginx/sites-available/n8n.conf

#2. Habilitar y reiniciar Nginx
ln -s /etc/nginx/sites-available/n8n.conf /etc/nginx/sites-enabled/

nginx -t

systemctl restart nginx
===================================================

#Generación de certificado SSL
# El registro DNS debe apuntar a la IP del servidor antes de este paso
certbot --nginx -d n8n-02.hunabku.mx
===================================================
