FROM node:slim 
RUN  useradd -ms /bin/bash user
RUN apt-get update && apt-get install gnupg wget -y && \
  wget --quiet --output-document=- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/google-archive.gpg && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
  apt-get update && \
  apt-get install google-chrome-stable -y --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

USER user
RUN mkdir /home/user/app
COPY test.js /home/user/app/test.js 
COPY package.json /home/user/app/package.json
WORKDIR /home/user/app
RUN npm install 
RUN npx puppeteer browsers install chrome
CMD node /home/user/app/test.js 
