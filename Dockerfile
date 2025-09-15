# Dockerfile
ARG N8N_VERSION=latest
FROM n8nio/n8n:${N8N_VERSION}

USER root

# Install Chromium dependencies
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates \
    fonts-liberation \
    wget \
    gnupg \
    lsb-release \
    unzip \
    xdg-utils \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxss1 \
    libasound2 \
    libx11-xcb1 \
    libxcomposite1 \
    libxrandr2 \
    libgbm1 \
    libgtk-3-0 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libxshmfence1 \
 && rm -rf /var/lib/apt/lists/*

# Puppeteer env
ENV PUPPETEER_CACHE_DIR=/home/node/.cache/puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=false

# Install puppeteer and community puppeteer node
RUN cd /usr/local/lib/node_modules/n8n \
 && npm install puppeteer@latest n8n-nodes-puppeteer --unsafe-perm=true --no-audit --no-fund \
 && chown -R node:node /usr/local/lib/node_modules/n8n /home/node/.cache

USER node
