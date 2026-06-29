# 🌐 EncryptGeneratorApi

![PowerBuilder](https://img.shields.io/badge/PowerBuilder-2025-orange?style=flat-square&logo=sap&logoColor=white)
![REST API](https://img.shields.io/badge/REST-RestClient-1F6FEB?style=flat-square&logo=postman&logoColor=white)
![Blog](https://img.shields.io/badge/blog-rsrsystem-FF5722?style=flat-square&logo=blogger&logoColor=white)

> La hermana **"conectada"** de EncryptGenerator: el mismo concepto, pero delegando el cifrado en una **API REST**. 🔌

---

## 📋 ¿Qué es esto?

Hace nada os hablé de [**EncryptGenerator**](https://github.com/rasanfe/EncryptGenerator),
una herramienta para **sacar las claves de cifrado fuera del código fuente**. La idea de
fondo es la misma: en el código solo vive una **Clave Maestra** y un **Vector Maestro**,
que únicamente sirven para abrir un **token** (un JSON cifrado) guardado en el `.ini`. Y
dentro de ese token están las **claves reales**:

```json
{ "key": "claveReal", "IV": "vectorReal" }
```

La diferencia está en **dónde se hace el trabajo sucio**. En la versión nativa, PowerBuilder
cifraba y descifraba él mismo con `crypterobject`. En **esta versión, todo eso se delega en
una API REST**: cifrar, descifrar y abrir el token son llamadas HTTP a un servicio externo.

¿Por qué querríais esto? Pues porque así **centralizáis el cifrado en un único sitio**: la
lógica y las claves maestras viven en el servidor, varias aplicaciones lo consumen, y el
cliente PowerBuilder se queda fino, sin saber los detalles del algoritmo.

## ✨ Cómo funciona

El protagonista vuelve a ser **`n_cst_security`**, pero esta vez por dentro es muy distinto:

- En lugar de `crypterobject`, monta un **`RestClient`** y hace peticiones **POST** con
  `SendPostRequest()` a los endpoints del servicio:
  - `POST /api/Security/token` → abre el token y devuelve `key` + `IV`.
  - `POST /api/Security/encrypt` → cifra un texto.
  - `POST /api/Security/decrypt` → descifra un texto.
- Los datos viajan en **JSON**, y antes de salir cada campo se codifica en **Base64URL**
  (con `nvo_coderobject`, una subclase de `coderobject`) para que ningún carácter raro
  rompa el viaje.
- El JSON de ida se construye con **`nvo_jsongenerator`** (subclase de `jsongenerator`),
  y la respuesta se lee con `JsonParser`. Todo nativo de PowerBuilder, sin librerías de por
  medio.

La URL base está en una constante del objeto:

```
is_ApiUrl        = "https://localhost:7923/api"
is_ApiController = "/Security"
```

Cambiad ahí la dirección para apuntar a vuestro propio servicio.

## 🛠️ Requisitos

- **PowerBuilder 2025** (usa `RestClient`, `jsongenerator` y `coderobject` nativos).
- Un **servicio REST de cifrado** escuchando en la URL configurada, con los endpoints
  `/token`, `/encrypt` y `/decrypt`. ⚠️ Sin la API levantada, el ejemplo no tiene con quién
  hablar.

## ▶️ Cómo probarlo

1. Clona el repo y abre `EncryptGeneratorApi.pbsln` en el IDE (**en modo solución**:
   clonas y compila).
2. Asegúrate de tener tu **API de cifrado en marcha** y ajusta `is_ApiUrl` /
   `is_ApiController` en `n_cst_security` si tu servicio vive en otra dirección.
3. Ejecuta la aplicación y usa los botones de **Encrypt / Decrypt** y la generación de
   **Token**: por debajo, cada acción se convierte en una llamada a la API.

## 🔗 Repo PowerBuilder

Tenéis el ejemplo publicado **en modo solución** aquí:
<https://github.com/rasanfe/EncryptGeneratorApi>

---

> ¡Nos vemos en el próximo artículo! Y recuerda: en PowerBuilder, los límites solo están en nuestra imaginación. 🚀

📨 **Blog:** <https://rsrsystem.blogspot.com/>
