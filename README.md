# Christian Grimberg - Currículum Profesional

Este repositorio aloja mi CV/Currículum profesional como sitio de GitHub Pages, construido con Jekyll.

## 🌐 Sitio en Vivo

Visitar el currículum en vivo en: [https://christiangrimberg.github.io/](https://christiangrimberg.github.io/)

## 🌍 Idiomas

El currículum está disponible en dos idiomas:

- **Inglés**: [https://christiangrimberg.github.io/](https://christiangrimberg.github.io/)
- **Español**: [https://christiangrimberg.github.io/es/](https://christiangrimberg.github.io/es/)

Usar el selector de idioma en la esquina superior derecha para alternar entre idiomas.

## 🛠️ Stack Tecnológico

- **Generador de sitio estático**: Jekyll 3.10+
- **Plantilla**: Basada en [jglovier/resume-template](https://github.com/jglovier/resume-template)
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions
- **Lenguajes**: Ruby 3.2, SCSS, plantillas Liquid

## 📁 Estructura del Proyecto

```txt
.
├── _config.yml             # Configuración del sitio
├── _layouts/               # Layouts de página
│   ├── resume.html         # Layout de currículum monolingüe
│   └── resume-i18n.html    # Layout de currículum bilingüe (usado por ambas páginas de inicio)
├── _includes/              # Componentes reutilizables
│   ├── head.html
│   ├── icon-links.html
│   ├── print-social-links.html
│   └── icons/              # Íconos SVG para enlaces sociales
├── _sass/                  # Hojas de estilo (partials)
│   ├── _base.scss
│   ├── _i18n.scss          # Estilos del selector de idioma
│   ├── _layout.scss
│   ├── _mixins.scss
│   ├── _normalize.scss
│   ├── _resume.scss
│   └── _variables.scss
├── _data/                  # Datos de contenido
│   ├── en/                 # Contenido en inglés
│   │   ├── strings.yml
│   │   ├── experience.yml
│   │   ├── education.yml
│   │   ├── continuing-education.yml
│   │   ├── skills.yml
│   │   ├── projects.yml
│   │   ├── recognitions.yml
│   │   └── links.yml
│   └── es/                 # Contenido en español (espejo archivo por archivo de en/)
│       └── (misma estructura)
├── css/                    # Puntos de entrada SCSS de nivel superior
│   ├── main.scss
│   └── markdown-styles.css
├── images/                 # Assets estáticos
│   └── avatar.jpg
├── index.html              # Página de inicio en inglés (lang: en)
├── es/
│   └── index.html          # Página de inicio en español (lang: es)
├── .github/
│   ├── dependabot.yml
│   └── workflows/
│       └── jekyll.yml      # Deploy de GitHub Pages
├── .gitignore              # Jekyll / Ruby / IDE / SO / estado del agente
├── .gitattributes          # Fin de línea LF, hints para assets binarios
├── .dockerignore           # Mantiene chico el contexto de `docker build`
├── Dockerfile              # ruby:3.2-slim + bundler 4.0.6 para desarrollo local
├── Gemfile                 # Dependencias de Ruby
└── Gemfile.lock            # Versiones pineadas (se mantiene tracked para builds reproducibles)
```

## 🚀 Desarrollo Local

Se puede correr el sitio localmente tanto con una instalación de Ruby en el host como con Docker (recomendado — evita pelearse con desajustes de versión de bundle contra el Ruby del sistema).

### 🐳 Opción A: Docker (recomendado)

Este repositorio incluye un `Dockerfile` que refleja exactamente el CI de GitHub Pages: `ruby:3.2-slim` más el mismo `bundler 4.0.6` pineado por `Gemfile.lock`. Un `docker build && docker run` exitoso equivale al build de producción.

Prerrequisitos: [Docker](https://docs.docker.com/get-docker/) 20+.

1. Construir la imagen:

   ```bash
   docker build -t christian-grimberg-cv .
   ```

2. Correr el servidor de desarrollo con live-reload. El bind mount permite editar `_data/`, `_layouts/`, `_sass/`, etc. en el host y ver los cambios al instante:

   ```bash
   docker run --rm -p 4000:4000 \
     -v "$PWD:/srv/jekyll" \
     christian-grimberg-cv
   ```

3. Abrir el navegador en [http://localhost:4000](http://localhost:4000).

> **Tip:** `--force_polling` está habilitado en el Dockerfile para que live-reload funcione en Docker Desktop para macOS, donde inotify no está disponible. En Linux se puede quitar.

### 🛠 Opción B: Ruby en el Host

Prerrequisitos: Ruby 3.2+, Bundler.

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/ChristianGrimberg/ChristianGrimberg.github.io.git
   cd ChristianGrimberg.github.io
   ```

2. Instalar dependencias:

   ```bash
   bundle install
   ```

3. Correr el servidor local:

   ```bash
   bundle exec jekyll serve
   ```

4. Abrir el navegador en [http://localhost:4000](http://localhost:4000).

## 📝 Actualizar Contenido

### Editar Información del Currículum

Todo el contenido del currículum está almacenado en archivos YAML bajo `_data/en/` y `_data/es/`:

- **Experiencia**: Editar `experience.yml`
- **Educación**: Editar `education.yml`
- **Habilidades**: Editar `skills.yml`
- **Proyectos**: Editar `projects.yml`
- **Certificaciones**: Editar `recognitions.yml`
- **Enlaces**: Editar `links.yml`
- **Strings de UI**: Editar `strings.yml`

### Agregar una Nueva Experiencia Laboral

Agregar a `_data/en/experience.yml` (y su equivalente en español):

```yaml
- company: Nombre de la Empresa
  position: Título del Puesto
  duration: Año de Inicio &mdash; Año de Fin (o Presente)
  summary: Descripción de tu rol y logros.
```

### Agregar una Nueva Habilidad

Agregar a `_data/en/skills.yml` (y su equivalente en español):

```yaml
- skill: Nombre de la Habilidad
  description: Descripción de tu experiencia en esta área.
```

## 🎨 Personalización

### Colores y Tema

Editar `_sass/_variables.scss` para cambiar colores y fuentes.

### Imagen de Avatar

Reemplazar `images/avatar.jpg` con tu propia foto (mantener el mismo nombre de archivo, o actualizar `resume_avatar` en `_config.yml`).

### Información de Contacto

Actualizar en `_config.yml`:

```yaml
resume_contact_email: "tu.email@example.com"
resume_contact_address: "Tu Ciudad, País"
```

## 🚢 Deploy

El sitio se deploya automáticamente vía GitHub Actions cuando se pushea a la rama `main`.

### Deploy Manual

```bash
bundle exec jekyll build
# El output quedará en _site/
```

## 📄 Licencia

La plantilla del currículum está basada en [jglovier/resume-template](https://github.com/jglovier/resume-template) bajo la Licencia MIT.

El contenido y la información personal son © Christian Grimberg.

## 📧 Contacto

- **Email**: [christian.grimberg@outlook.com](mailto:christian.grimberg@outlook.com)
- **LinkedIn**: [linkedin.com/in/christiangrimberg](https://www.linkedin.com/in/christiangrimberg)
- **GitHub**: [github.com/ChristianGrimberg](https://github.com/ChristianGrimberg)


## Presentación y CV resumido

- El perfil completo mantiene los 37 proyectos en un archivo desplegable y destaca seis iniciativas mediante `featured: true` en ambos `projects.yml`. Los IDs deben coincidir entre idiomas.
- `/cv/` y `/es/cv/` son versiones resumidas independientes para imprimir o guardar como PDF. El objetivo de maquetación es de dos páginas; el resultado depende del navegador, papel y ajustes de impresión. Usar escala 100 %, sin encabezados/pies del navegador.
- Los resúmenes para impresión se mantienen en `print_summary` dentro de `experience.yml`, sin eliminar la trayectoria completa.
- `css/modern.css` contiene el diseño responsive y las reglas de impresión; conserva el selector de modo oscuro.
- Las certificaciones y reconocimientos se distinguen mediante `kind` en `recognitions.yml`. No añadir credenciales sin confirmar.
- El workflow `Validate bilingual CV` construye Jekyll y ejecuta `ruby script/validate_cv.rb` en pull requests; no despliega. El despliegue existente sigue limitado a `main`.

## Compatibilidad de lectura ATS (PDF resumido)

Las vistas `/cv/` y `/es/cv/` usan una columna de texto seleccionable, sin foto,
tablas ni información esencial en encabezados/pies repetidos. El resumen,
experiencia, competencias técnicas, certificaciones y educación tienen títulos
explícitos; cada cargo conserva empresa y fechas. El diseño del perfil web no cambia.

Después de generar los PDFs con el workflow de revisión, ejecutar:

```bash
ruby script/validate_pdf.rb preview-artifacts
```

Requiere las herramientas `pdfinfo`, `pdffonts` y `pdftotext` de Poppler
(`poppler-utils` en Ubuntu). CI verifica ambos idiomas, dos páginas A4, fuentes
incrustadas con mapa Unicode, texto extraíble en orden de lectura y modo layout,
y presencia de contacto, cargos, empresas, fechas, tecnologías y credenciales.
Los errores bloquean la validación del PR. No se envía el CV a un servicio ATS.

Estos controles detectan regresiones de legibilidad, **no garantizan superar un
ATS ni asignan un puntaje de candidatura**. Los requisitos y palabras clave
varían por vacante: adaptar el contenido solo con experiencia real y relevante,
sin texto oculto ni acumulación artificial de términos. Revisar siempre los
campos importados en la postulación y usar el formato pedido por el empleador.

Referencias de proveedor (consultadas el 22/10/2026):
- [Greenhouse: errores de parsing y formatos complejos](https://support.greenhouse.io/hc/en-us/articles/200989175-Unsuccessful-resume-parse)
- [Greenhouse: parsing en idiomas distintos del inglés](https://support.greenhouse.io/hc/en-us/articles/205019689-Resume-parsing-with-non-English-languages)
- [Greenhouse: filtros por palabras clave y criterios de búsqueda](https://support.greenhouse.io/hc/en-us/articles/27104809835291-Talent-Filtering)
