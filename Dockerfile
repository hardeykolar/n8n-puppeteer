# 1. Start from the official n8n image
FROM n8nio/n8n:latest

# 2. Switch to root to install dependencies
USER root

# 3. Install required dependencies for Puppeteer/Chromium
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    fonts-liberation \
    wget \
    gnupg \
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
    chromium \
 && rm -rf /var/lib/apt/lists/*

# 4. Set Puppeteer to use installed Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 5. Install puppeteer
RUN npm install -g puppeteer

# 6. Switch back to n8n user
USER node
