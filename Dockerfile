# 1. Start from official n8n image
FROM n8nio/n8n:latest

# 2. Switch to root for installation
USER root

# 3. Install dependencies & chromium from Playwright repo
RUN apt-get update && apt-get install -y wget gnupg ca-certificates \
 && wget -qO- https://deb.nodesource.com/setup_18.x | bash - \
 && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
 && install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/ \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge.list \
 && apt-get update && apt-get install -y --no-install-recommends \
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
 && rm -rf /var/lib/apt/lists/*

# 4. Set Puppeteer to use installed Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 5. Install puppeteer
RUN npm install -g puppeteer

# 6. Switch back to n8n user
USER node
