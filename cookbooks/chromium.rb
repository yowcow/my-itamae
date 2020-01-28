# Things required to run Puppeteer/Chromium

%w{
  libatk-bridge2.0-0
  libasound2
  libatk1.0-0
  libgtk-3-0
  libnss3
  libx11-xcb1
  libxcomposite1
  libxcursor1
  libxdamage1
  libxfixes3
  libxi6
  libxrandr2
  libxss1
  libxtst6
  x11-common
}.each do |pkg|
  package pkg
end
