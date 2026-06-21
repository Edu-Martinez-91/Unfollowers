<div align="center">

<img src="docs/logo.svg" alt="Unfollowers" width="120" height="120">

# IG Unfollowers

**Descubre quién no te sigue de vuelta en Instagram — un solo archivo HTML, sin frameworks, sin build, sin npm, sin servidor.**

[![Made with vanilla JS](https://img.shields.io/badge/Vanilla-JS-f7df1e?logo=javascript&logoColor=black)](https://developer.mozilla.org/docs/Web/JavaScript)
[![Deploy: Netlify](https://img.shields.io/badge/Deploy-Netlify-00c7b7?logo=netlify&logoColor=white)](https://www.netlify.com)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](#licencia)
[![Single file](https://img.shields.io/badge/Single--file-HTML-orange)]()
[![Privacy: local by default](https://img.shields.io/badge/Privacy-local%20by%20default-success)]()

*Abre `index.html` en cualquier navegador — no requiere instalación ni cuenta. La sincronización en la nube es opcional.*

🇪🇸 **Español** · [🇬🇧 English](README.en.md)

</div>

---

## ¿Qué es esto?

> Esta app nace de los niveles más oscuros donde residen la vanidad y el orgullo: *"si tú no me sigues, yo no te sigo"*. No te vamos a juzgar por estar aquí — solo te vamos a dar las herramientas.

**Unfollowers** compara los dos archivos JSON que Instagram te entrega cuando exportas tu actividad (`following.json` y `followers_*.json`) y calcula, en tu propio navegador, quién sigues tú que no te sigue de vuelta. Nada de pedir tu usuario o contraseña, nada de OAuth, nada de scraping con bots que pueda bloquear tu cuenta: solo lees los archivos que Instagram ya te da oficialmente.

Toda la aplicación cabe en un único `index.html`. No hay build, no hay dependencias de npm. El procesamiento es 100% client-side y el estado (cuentas marcadas como VIP, como "ya hice unfollow" o como "no disponible") se guarda en `localStorage` de tu navegador. Si quieres que ese estado viaje contigo entre dispositivos, puedes iniciar sesión opcionalmente y sincronizarlo contra una base de datos en Supabase — sin login, la app sigue funcionando 100% local, igual que siempre.

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
- **Export/import de copia de seguridad** de tus etiquetas en `.json`, para moverlas manualmente de un navegador a otro sin necesidad de cuenta.
- **Comparación antes de importar.** Si el archivo que importas no coincide exactamente con lo que ya tienes (local o en la nube), aparece un aviso con el recuento de cada lado y tres opciones explícitas — combinar, quedarte con lo actual o quedarte con el archivo — para que ninguna importación pueda borrar datos sin que lo decidas tú mismo.
- **Sincronización en la nube (opcional).** Inicia sesión con email/contraseña y tus etiquetas VIP/unfollowed/no-disponible se guardan en Supabase y se fusionan automáticamente con las de cualquier otro dispositivo donde abras la app — sin perder nada, sin tener que volver a categorizar.
- **Toast de confirmación** en cada acción, sin diálogos intrusivos.

---

## Stack

| Capa | Tecnología |
|------|------------|
| **Frontend** | Un solo archivo HTML con `<style>` y `<script>` inline. Vanilla JS, sin frameworks ni librerías externas. |
| **Persistencia local** | `localStorage` del navegador — funciona sin cuenta ni conexión. |
| **Sincronización (opcional)** | [Supabase](https://supabase.com) — Auth (email/contraseña) + Postgres con Row Level Security. Una sola tabla, `unfollowers_tags`, con tus etiquetas en una columna `jsonb`. |
| **Hosting** | [Netlify](https://www.netlify.com), `index.html` en la raíz. Despliegue continuo desde `main`. |
| **Tipografía** | Space Mono (UI) + Syne (titulares), vía Google Fonts. |
| **Privacidad** | Sin iniciar sesión, cero llamadas de red salvo la carga de fuentes: los JSON de Instagram se procesan enteramente en el navegador y nunca salen del dispositivo. Si activas la sincronización, solo tus etiquetas (no los JSON de Instagram) viajan a tu base de datos en Supabase. |

---

## Privacidad

Tus archivos `following.json` y `followers_*.json` **nunca salen del navegador**: el `FileReader` de la API los lee directamente en memoria, y por defecto el único almacenamiento persistente es el `localStorage` de tu propio dispositivo. Puedes verificarlo abriendo las herramientas de desarrollador → pestaña Red mientras usas la app: no encontrarás ninguna petición saliente con esos datos, con o sin sesión iniciada.

La única información que sale de tu dispositivo, y solo si decides iniciar sesión, son los nombres de usuario que tú mismo has marcado como VIP, unfollowed o no disponible — se guardan en una base de datos Supabase protegida por Row Level Security, de forma que cada cuenta de usuario solo puede leer y escribir sus propias etiquetas.

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
