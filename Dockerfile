# syntax=docker/dockerfile:1
#
# Reproducible local Jekyll build for Christian Grimberg's CV site.
# Mirrors the GitHub Pages CI (.github/workflows/jekyll.yml) so that
# a successful `docker build && docker run` equals the production build.
#
# Build:  docker build -t cv .
# Run:    docker run --rm -p 4000:4000 -v "$PWD:/srv/jekyll" cv
#         (the bind mount lets live-reload pick up edits from the host)
#

FROM ruby:3.2-slim

# nokogiri / github-pages / activesupport build against a few system libs.
# Slim lacks them; install with --no-install-recommends to keep the image small.
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
        build-essential \
        libffi-dev \
        libxml2-dev \
        libxslt1-dev \
        libssl-dev \
        libyaml-dev \
        zlib1g-dev \
        git \
 && rm -rf /var/lib/apt/lists/*

# Match the version pinned by Gemfile.lock (BUNDLED WITH 4.0.6 as of this commit).
ARG BUNDLER_VERSION=4.0.6
RUN gem install bundler:${BUNDLER_VERSION} --no-document

WORKDIR /srv/jekyll

# Install gems first so the layer caches across content-only rebuilds.
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local path /usr/local/bundle \
 && bundle install --jobs 4 --retry 3

# Copy the rest of the source. .dockerignore keeps _site/.git/.hermes/etc. out.
COPY . .

EXPOSE 4000

# --force_polling pairs with the bind mount so host edits trigger live-reload
# on filesystems where inotify isn't available (Docker Desktop on macOS).
CMD ["bundle", "exec", "jekyll", "serve", \
     "--host", "0.0.0.0", \
     "--port", "4000", \
     "--livereload", \
     "--force_polling"]
