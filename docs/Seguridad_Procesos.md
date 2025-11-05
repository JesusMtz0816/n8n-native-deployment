# SEGURIDAD Y PROCESOS

### 1. Seguridad del Sistema Base (Linux y Red)

| **Acción** | **Detalle de Implementación** | **Razón** |
| --- | --- | --- |
| **Firewall (UFW)** | Verificar que UFW esté activo y solo los puertos 22 (SSH), 80 (HTTP) y 443 (HTTPS) estén abiertos. | Bloquea el tráfico no deseado, protegiendo servicios internos como PostgreSQL (puerto 5432). |
| **Auditoría de Logs** | Monitorear el estado del servicio n8n con `journalctl -u n8n.service`. | Diagnóstico rápido de fallos de inicio o errores internos de la aplicación. |
| **Actualizaciones** | Ejecutar `apt update && apt upgrade -y` regularmente. | Mantener el sistema operativo, Node.js y PostgreSQL parcheados contra vulnerabilidades. |

### 2. Gestión del Servicio Nativo (Systemd)

| **Comando** | **Propósito** |
| --- | --- |
| **`systemctl status n8n.service`** | Verificar que la aplicación esté **`active (running)`**. |
| **`systemctl restart n8n.service`** | Reiniciar el servicio de n8n (necesario tras cambios en `.env` o tras depurar fallos de conexión de BD). |
| **`systemctl stop n8n.service`** | Detener el servicio por completo. |
| **`journalctl -u n8n.service -f`** | Ver los logs de la aplicación en tiempo real (útil para depurar errores de flujo o de conexión). |

### 3. Procesos de Mantenimiento de la Base de Datos

| **Acción** | **Detalle de Implementación** | **Razón** |
| --- | --- | --- |
| **Visualización y Mantenimiento** | **Usar DBeaver y Túnel SSH** (puerto `5433` a `localhost:5432`) para ver las tablas `users`, `interactions`, y `products`. | Es la única forma segura y visual de inspeccionar el *schema* y los datos sin exponer el puerto 5432. |
| **Copia de Seguridad (Backup)** | Usar el comando `pg_dump` para generar copias de seguridad diarias de la base de datos `n8n_database`. | Previene la pérdida de datos de auditoría y credenciales en caso de fallo del disco duro o corrupción de datos. |
| **Migración de n8n** | El proceso de migración de la BD de n8n se ejecuta automáticamente al inicio si hay un cambio de versión. | Se asegura la compatibilidad de las tablas internas de n8n con la nueva versión del software. |

### 4. Gestión de Claves y Credenciales

| **Dato** | **Ubicación de la Clave** | **Protocolo de Seguridad** |
| --- | --- | --- |
| **Clave de Encriptación (N8N_ENCRYPTION_KEY)** | Fijo en el archivo `n8n.service` y la BD. **(CRÍTICO)** | No debe cambiarse a menos que se desee invalidar las credenciales cifradas antiguas. |
| **Credenciales de Servicios** | Gestionadas a través de la interfaz web de n8n. | Deben ser tokens de larga duración (ej. System User Token para WhatsApp) y se deben revocar inmediatamente si hay sospecha de compromiso. |