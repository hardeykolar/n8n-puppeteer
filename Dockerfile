# 1. Use Debian-based n8n image
FROM n8nio/n8n:1.81.1-debian

# 2. Switch to root for installation
USER root

# 3. Install Chromium & dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    chromium \
    ca-certificates \
    fonts-liberation \
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
    xdg-utils \
    unzip \
    wget \
    gnupg \
 && rm -rf /var/lib/apt/lists/*

# 4. Install Puppeteer globally
RUN npm install -g puppeteer

# 5. Set Puppeteer to use system Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 6. Switch back to node user
USER node
