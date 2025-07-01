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

# Download and install Chromedriver
wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/138.0.7204.92/linux64/chromedriver-linux64.zip
unzip chromedriver-linux64.zip
sudo mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
sudo chmod +x /usr/local/bin/chromedriver
rm -f chromedriver-linux64.zip
rm -rf chromedriver-linux64

# Validate installations
google-chrome --version
chromedriver --version
