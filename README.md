# Christian Grimberg - Professional Resume

This repository hosts my professional CV/Resume as a GitHub Pages site, built with Jekyll.

## 🌐 Live Site

Visit the live resume at: [https://christiangrimberg.github.io/](https://christiangrimberg.github.io/)

## 🌍 Languages

The resume is available in two languages:

- **English**: [https://christiangrimberg.github.io/](https://christiangrimberg.github.io/)
- **Español**: [https://christiangrimberg.github.io/es/](https://christiangrimberg.github.io/es/)

Use the language switcher in the top-right corner to toggle between languages.

## 🛠️ Technology Stack

- **Static Site Generator**: Jekyll 3.10+
- **Template**: Based on [jglovier/resume-template](https://github.com/jglovier/resume-template)
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions
- **Languages**: Ruby 3.2, SCSS, Liquid templates

## 📁 Project Structure

```txt
.
├── _config.yml             # Site configuration
├── _layouts/               # Page layouts
│   ├── resume.html         # Single-language resume layout
│   └── resume-i18n.html    # Bilingual resume layout (used by both index pages)
├── _includes/              # Reusable components
│   ├── head.html
│   ├── icon-links.html
│   ├── print-social-links.html
│   └── icons/              # SVG icons for social links
├── _sass/                  # Stylesheets (partials)
│   ├── _base.scss
│   ├── _i18n.scss          # Language switcher styles
│   ├── _layout.scss
│   ├── _mixins.scss
│   ├── _normalize.scss
│   ├── _resume.scss
│   └── _variables.scss
├── _data/                  # Content data
│   ├── en/                 # English content
│   │   ├── strings.yml
│   │   ├── experience.yml
│   │   ├── education.yml
│   │   ├── continuing-education.yml
│   │   ├── skills.yml
│   │   ├── projects.yml
│   │   ├── recognitions.yml
│   │   └── links.yml
│   └── es/                 # Spanish content (file-for-file mirror of en/)
│       └── (same structure)
├── css/                    # Top-level SCSS entry points
│   ├── main.scss
│   └── markdown-styles.css
├── images/                 # Static assets
│   └── avatar.jpg
├── index.html              # English homepage (lang: en)
├── es/
│   └── index.html          # Spanish homepage (lang: es)
├── .github/
│   ├── dependabot.yml
│   └── workflows/
│       └── jekyll.yml      # GitHub Pages deploy
├── .gitignore              # Jekyll / Ruby / IDE / OS / agent state
├── .gitattributes          # LF line endings, binary asset hints
├── .dockerignore           # Keeps `docker build` context small
├── Dockerfile              # ruby:3.2-slim + bundler 4.0.6 for local dev
├── Gemfile                 # Ruby dependencies
└── Gemfile.lock            # Pinned versions (kept tracked for reproducible builds)
```

## 🚀 Local Development

You can run the site locally either with a host Ruby installation or with Docker (recommended — avoids fighting bundle version mismatches against the system Ruby).

### 🐳 Option A: Docker (recommended)

This repo ships a `Dockerfile` that mirrors the GitHub Pages CI exactly: `ruby:3.2-slim` plus the same `bundler 4.0.6` pinned by `Gemfile.lock`. A successful `docker build && docker run` is equivalent to the production build.

Prerequisites: [Docker](https://docs.docker.com/get-docker/) 20+.

1. Build the image:

   ```bash
   docker build -t christian-grimberg-cv .
   ```

2. Run the dev server with live-reload. The bind mount lets you edit `_data/`, `_layouts/`, `_sass/`, etc. on the host and see changes instantly:

   ```bash
   docker run --rm -p 4000:4000 \
     -v "$PWD:/srv/jekyll" \
     christian-grimberg-cv
   ```

3. Open your browser to [http://localhost:4000](http://localhost:4000).

> **Tip:** `--force_polling` is enabled in the Dockerfile so live-reload works on Docker Desktop for macOS, where inotify isn't available. On Linux you can drop it.

### 🛠 Option B: Host Ruby

Prerequisites: Ruby 3.2+, Bundler.

1. Clone the repository:

   ```bash
   git clone https://github.com/ChristianGrimberg/ChristianGrimberg.github.io.git
   cd ChristianGrimberg.github.io
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Run the local server:

   ```bash
   bundle exec jekyll serve
   ```

4. Open your browser to [http://localhost:4000](http://localhost:4000).

## 📝 Updating Content

### Editing Resume Information

All resume content is stored in YAML files under `_data/en/` and `_data/es/`:

- **Experience**: Edit `experience.yml`
- **Education**: Edit `education.yml`
- **Skills**: Edit `skills.yml`
- **Projects**: Edit `projects.yml`
- **Certifications**: Edit `recognitions.yml`
- **Links**: Edit `links.yml`
- **UI Strings**: Edit `strings.yml`

### Adding a New Job Experience

Add to `_data/en/experience.yml` (and Spanish equivalent):

```yaml
- company: Company Name
  position: Job Title
  duration: Start Year &mdash; End Year (or Present)
  summary: Description of your role and achievements.
```

### Adding a New Skill

Add to `_data/en/skills.yml` (and Spanish equivalent):

```yaml
- skill: Skill Name
  description: Description of your expertise in this area.
```

## 🎨 Customization

### Colors and Theme

Edit `_sass/_variables.scss` to change colors and fonts.

### Avatar Image

Replace `images/avatar.jpg` with your own photo (keep the same filename, or update `resume_avatar` in `_config.yml`).

### Contact Information

Update in `_config.yml`:

```yaml
resume_contact_email: "your.email@example.com"
resume_contact_address: "Your City, Country"
```

## 🚢 Deployment

The site automatically deploys via GitHub Actions when changes are pushed to the `main` branch.

### Manual Deployment

```bash
bundle exec jekyll build
# Output will be in _site/
```

## 📄 License

The resume template is based on [jglovier/resume-template](https://github.com/jglovier/resume-template) under the MIT License.

The content and personal information are © Christian Grimberg.

## 📧 Contact

- **Email**: [christian.grimberg@outlook.com](mailto:christian.grimberg@outlook.com)
- **LinkedIn**: [linkedin.com/in/christiangrimberg](https://www.linkedin.com/in/christiangrimberg)
- **GitHub**: [github.com/ChristianGrimberg](https://github.com/ChristianGrimberg)
