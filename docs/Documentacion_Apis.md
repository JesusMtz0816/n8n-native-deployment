# Documentación Apis WhatsApp, Telegram y Google Gemini.

## 1. Crea una App en Meta for Developers

1. Ve a [**https://developers.facebook.com**](https://developers.facebook.com) y haz login con tu cuenta.
2. Menú → **My Apps** → **Create App**.
    - Tipo de app: **Business** (o el que sugiera para WhatsApp).
    - Pon nombre (ej. `BarberiaAssistantApp`) y correo.
3. Tras crearla tendrás **App ID** y dentro del apartado **Settings → Basic** verás **App ID** y **App Secret**.
    - **App Secret**: haz clic en *Show* y cópialo (guárdalo seguro).
    - Estos los usarás para intercambiar tokens o crear tokens de larga duración.

---

## 2. Agregar el producto WhatsApp a la App

1. Dentro de tu App, en la columna izquierda → **Add Product** → selecciona **WhatsApp** → *Set up*.
2. En la sección **Getting Started / Tools**, Meta te muestra un **Phone Number** de prueba y un **Temporary Access Token** (si estás en la consola de Cloud API).
    - Copia el **Temporary Access Token** (es el token corto que te permite probar).
    - **Nota:** este token vence (por ejemplo 24h o 60d). Para producción debes obtener token de larga duración o token de system user.

---

## 3. Crear y usar Business Manager y obtener WABA ID

1. Ve a [**business.facebook.com**](http://business.facebook.com) → si no tienes Business Manager créalo.
2. Dentro del Business Manager, añade una **WhatsApp Business Account** (si no existe).
    - En Business settings → Accounts → WhatsApp accounts → *Add*.
3. Obtén tu **WhatsApp Business Account ID (WABA ID)**.
    - Alternativamente, en la App → WhatsApp → *Settings* suele mostrar el `WhatsApp Business Account` y su ID.

---

## 4. Obtener el Phone Number ID

Existen diferentes opciones pero nosotros utilizaremos a la siguiente:

**Opción A: Desde la consola de la App (más simple para pruebas):**

- En App → WhatsApp → *Tools* / *Phone Numbers* verás el número provisto (test) y su **Phone Number ID**.

## 5. Generar Access Token válido para usar en n8n

Opción A:

**- Token temporal desde App Dashboard (rápido, pruebas):**

- En App → WhatsApp → *Tools* → `Generate Token (temporary)`.
- Úsalo como `Authorization: Bearer <TOKEN>` en tus llamados HTTP.
- Vence pronto (1  hora de duración), a pesar de que es muy útil para nuestras pruebas, no sirve para producción.

Opción B:

**- System User token (recomendado para producción en Business Manager)**

1. Ve a **Business Manager → Settings → System Users**.
2. Crea un **System User** (tipo Admin).
3. Dentro del System User, **Generate New Token** y asigna permisos:
    - `whatsapp_business_messaging`
    - `whatsapp_business_management`
    - (si necesitas gestionar páginas: `pages_manage_metadata`, etc.)
4. El token generado por System User **puede ser permanente** hasta que lo revokes — ideal para servidores/backend (poner en n8n Credentials).

## 6. Conectar el Nodo de WhatsApp

Finalmente, en la plataforma de automatización N8N (nodo de WhatsApp), usamos las credenciales recopiladas:

1. **Token de Acceso (Bearer Token):** El Token permanente que generaste en el paso 2.
2. **ID de la Cuenta de WhatsApp Business:** El WABA ID que anotamos.
3. **ID del Número de Teléfono:** El Phone Number ID que anotamos.

Con estas tres credenciales primarias, podremos configurar la autenticación en nuestro nodo para comenzar a enviar mensajes salientes. La configuración del Webhook nos permitirá recibir mensajes entrantes y procesarlos nuestro flujo.

---

---

## 1. Obtención del Bot Token de Telegram

1. Ve a [https://telegram.me/BotFather](https://telegram.me/BotFather), abre Telegram e Inicia una conversación con `/newbot` o `/token` (si ya tienes un bot).
2. Sigue las instrucciones para asignar un **nombre** y un **username** (debe terminar en `bot`).
3. BotFather te proporcionará el **Bot Token** (`XXXXXXXXX:YYYYYYYY...`). Cópialo  pues el que usaremos al generar la credencial en el nodo de Telegram.

## 2. Recomendaciones

1.  Utiliza `/setprivacy` en BotFather y deshabilita la privacidad para asegurar que tu bot pueda leer todos los mensajes en un grupo.

---

---

## Obtención de la API Key de Google Gemini (AI Agent)

Esta clave es necesaria para el nodo **Google Gemini Chat Model** que procesa la consulta SQL.

### 1. Acceso al Panel de Desarrolladores de Google AI

1. Ve a [https://aistudio.google.com/welcome](https://aistudio.google.com/welcome) y asegúrate de haber iniciado sesión con la cuenta de Google que deseas vincular a la API.

### 2. Generación de la Nueva Clave de API

1. Busca la sección o el botón para **"Create API Key"** (Crear clave de API).
2. Haz clic para generar la nueva clave.

### 3. Copiar y Asegurar la Clave

1. La clave generada se mostrará en la pantalla una sola vez, es importante copiar la clave antes de cerrar la ventana.
2. Asegúrala en un gestor de contraseñas o en un archivo cifrado, ya que no se podrá recuperar después.
3. Si se pierde, el procedimiento es revocar la clave antigua y generar una nueva.

### 4. Uso de la Credencial en n8n

1. En n8n, crea una credencial de tipo **Google Gemini API**.
2. Pega la clave que acabas de generar en el campo **API Key**.