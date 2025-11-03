#!/bin/bash
# Cargar variables de entorno desde el archivo .env
set -a
. /home/n8n_data/.env
set +a

# Ejecutar n8n
/usr/local/bin/n8n start
