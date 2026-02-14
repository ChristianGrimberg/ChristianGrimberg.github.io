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
├── _config.yml           # Site configuration
├── _layouts/             # Page layouts
│   └── resume-i18n.html  # Bilingual resume layout
├── _includes/            # Reusable components
├── _sass/                # Stylesheets
│   └── _i18n.scss        # Language switcher styles
├── _data/                # Content data
│   ├── en/               # English content
│   │   ├── strings.yml
│   │   ├── experience.yml
│   │   ├── education.yml
│   │   ├── skills.yml
│   │   ├── projects.yml
│   │   ├── recognitions.yml
│   │   └── links.yml
│   └── es/               # Spanish content
│       └── (same structure)
├── index.html            # English homepage
└── es/
    └── index.html        # Spanish homepage
```

## 🚀 Local Development

### Prerequisites

- Ruby 3.2+
- Bundler

### Setup

1. Clone the repository:

  ```bash
  git clone https://github.com/ChristianGrimberg/ChristianGrimberg.git
  cd ChristianGrimberg
  ```

2. Install dependencies:

  ```bash
  bundle install
  ```

3. Run the local server:

  ```bash
  bundle exec jekyll serve
  ```

4. Open your browser to [http://localhost:4000](http://localhost:4000)

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

Replace `images/avatar.jpg` with your own photo.

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
