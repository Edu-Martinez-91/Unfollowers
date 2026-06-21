<div align="center">

<img src="docs/logo.svg" alt="Unfollowers" width="120" height="120">

# IG Unfollowers

**Descubre quién no te sigue de vuelta en Instagram — un solo archivo HTML, sin frameworks, sin build, sin npm, sin servidor.**

[![Made with vanilla JS](https://img.shields.io/badge/Vanilla-JS-f7df1e?logo=javascript&logoColor=black)](https://developer.mozilla.org/docs/Web/JavaScript)
[![Deploy: Netlify](https://img.shields.io/badge/Deploy-Netlify-00c7b7?logo=netlify&logoColor=white)](https://www.netlify.com)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](#licencia)
[![Single file](https://img.shields.io/badge/Single--file-HTML-orange)]()
[![Privacy: 100% local](https://img.shields.io/badge/Privacy-100%25%20local-success)]()

*Abre `index.html` en cualquier navegador — no requiere instalación, no requiere cuenta, no envía ningún dato a ningún servidor.*

🇪🇸 **Español** · [🇬🇧 English](README.en.md)

</div>

---

## ¿Qué es esto?

**Unfollowers** compara los dos archivos JSON que Instagram te entrega cuando exportas tu actividad (`following.json` y `followers_*.json`) y calcula, en tu propio navegador, quién sigues tú que no te sigue de vuelta. Nada de pedir tu usuario o contraseña, nada de OAuth, nada de scraping con bots que pueda bloquear tu cuenta: solo lees los archivos que Instagram ya te da oficialmente.

Toda la aplicación cabe en un único `index.html`. No hay backend, no hay build, no hay dependencias de npm. El procesamiento es 100% client-side y el estado (cuentas marcadas como VIP, como "ya hice unfollow" o como "no disponible") se guarda en `localStorage` de tu navegador.

---

## ¿Por qué Unfollowers?

Existen decenas de apps y "servicios" de terceros que prometen decirte quién te deja de seguir en Instagram. La inmensa mayoría te pide iniciar sesión con tus credenciales de Instagram o conceder permisos OAuth a una app de terceros — algo que viola los términos de servicio de Instagram y pone en riesgo el bloqueo de tu cuenta, además de exponer tus datos a un servidor ajeno.

1. **Cero riesgo para tu cuenta.** No inicias sesión en ningún sitio. Solo usas el export de datos que Instagram te ofrece oficialmente desde sus propios ajustes — el mismo mecanismo que usarías para un backup o una solicitud RGPD.
2. **Cero fuga de datos.** Todo el cálculo —parseo de JSON, comparación de listas, persistencia de tus marcas— ocurre en el navegador. Ningún archivo se sube a ningún servidor; no hay backend que lo reciba.
3. **Gestión real del "a quién quito", no solo una lista fría.** La lista de no-seguidores se puede marcar cuenta a cuenta como **VIP** (gente o marcas que sigues a propósito aunque no te sigan, p. ej. medios o famosos), **unfollowed** (cuentas a las que ya les diste unfollow manualmente en la app de Instagram) o **no disponible** (cuenta bloqueada, eliminada o suspendida). Estas marcas persisten entre sesiones y sobreviven a que vuelvas a cargar exports más recientes.
4. **Soporta el export real de Instagram, partido en varios archivos.** Instagram divide tus seguidores en `followers_1.json`, `followers_2.json`, etc. cuando tienes muchos. La app permite seleccionarlos todos a la vez y los fusiona automáticamente, deduplicando por usuario.
5. **Auditoría rápida con orden y búsqueda.** Lista ordenable por fecha de seguimiento (recientes o antiguos primero) y con buscador en vivo, para revisar cientos de cuentas sin perder el hilo.

---

## Cómo usarlo

1. En Instagram: **Ajustes → Tu actividad → Descargar tu información**.
2. Elige formato **JSON** y solicita la descarga (Instagram te avisa por email cuando está lista, normalmente en minutos).
3. Descomprime el ZIP que te llega y entra en `connections/followers_and_following/`.
4. Sube aquí `following.json` en el primer recuadro, y todos los `followers_X.json` que existan en el segundo (puedes seleccionarlos todos a la vez).
5. La app calcula al instante quién sigues que no te sigue de vuelta.

---

## Características

- **Comparación instantánea** entre `following.json` y uno o varios `followers_*.json`, deduplicando usuarios repetidos entre archivos.
- **Drag & drop o selector de archivos**, con detección de carga y aviso si Instagram partió tus seguidores en múltiples ficheros.
- **Tres etiquetas manuales por cuenta** — VIP / unfollowed / no disponible — con contador propio y persistencia en `localStorage`.
- **Auto-limpieza de marcas obsoletas.** Si vuelves a cargar exports más recientes y una cuenta ya no aparece como no-seguidor (porque empezó a seguirte o dejaste de seguirla), su marca se elimina automáticamente para no acumular basura.
- **Buscador en vivo** por nombre de usuario sobre las cuatro secciones (normales, VIP, unfollowed, no disponibles).
- **Orden por fecha de seguimiento**, ascendente o descendente, con un solo botón.
- **Acordeones plegables** por sección, con badges de conteo en tiempo real.
- **Acceso directo al perfil** de cada cuenta desde la propia tarjeta (abre Instagram en una pestaña nueva).
- **Modo claro/oscuro automático** según las preferencias del sistema (`prefers-color-scheme`).
- **Botones de purga** para borrar VIPs, unfollowed o no disponibles guardados, por si quieres empezar de cero.
- **Toast de confirmación** en cada acción, sin diálogos intrusivos.

---

## Stack

| Capa | Tecnología |
|------|------------|
| **Frontend** | Un solo archivo HTML con `<style>` y `<script>` inline. Vanilla JS, sin frameworks ni librerías externas. |
| **Persistencia** | `localStorage` del navegador — sin base de datos, sin backend, sin cuentas de usuario. |
| **Hosting** | [Netlify](https://www.netlify.com), `index.html` en la raíz. Despliegue continuo desde `main`. |
| **Tipografía** | Space Mono (UI) + Syne (titulares), vía Google Fonts. |
| **Privacidad** | Cero llamadas de red salvo la carga de fuentes. Los JSON de Instagram se procesan enteramente en el navegador y nunca salen del dispositivo. |

---

## Privacidad

Esta herramienta no tiene backend. No hay servidor que reciba tus archivos `following.json` o `followers_*.json`: el `FileReader` de la API del navegador los lee directamente en memoria, y el único almacenamiento persistente es el `localStorage` de tu propio navegador, que nunca abandona tu dispositivo. Puedes verificarlo abriendo las herramientas de desarrollador → pestaña Red mientras usas la app: no encontrarás ninguna petición saliente con tus datos.

---

## Desarrollo local

No requiere instalación. Basta con abrir `index.html` directamente en el navegador, o servirlo con cualquier servidor estático:

```bash
python3 -m http.server 8000
# o
npx serve .
```

---

## Licencia

Distribuido bajo licencia **GPLv3**. Consulta el archivo [LICENSE](LICENSE) para más detalles.
