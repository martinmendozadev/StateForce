#!/bin/bash

# Update package list
sudo apt-get update

# Install required system dependencies
sudo apt-get install -y wget unzip xvfb libnss3 libxi6 libxcursor1 libxrandr2 libxss1 libxtst6 libasound2t64 fonts-liberation libappindicator3-1 indicator-application xdg-utils

# Add Google Chrome signing key and repository
wget -q -O /usr/share/keyrings/google-chrome.gpg https://dl.google.com/linux/linux_signing_key.pub
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

# Update package list again and install Google Chrome
sudo apt-get update
sudo apt-get install -y google-chrome-stable

# We intentionally do NOT install a fixed chromedriver version.
# Selenium Manager (bundled with selenium-webdriver >= 4.6) will download a matching driver at runtime.
# This avoids version drift between Chrome and Chromedriver in CI.

# Validate Chrome installation; chromedriver may not exist yet (ignore failure).
google-chrome --version
chromedriver --version || echo "Chromedriver not preinstalled; Selenium Manager will provide it at runtime."
