FROM node:8.10.0

RUN mkdir -p /usr/src/garie-lighthouse
WORKDIR /usr/src/garie-lighthouse

COPY package.json .

RUN npm install

# Install Google Chrome
RUN \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable

COPY . .

COPY docker-entrypoint.sh /

EXPOSE 3000

VOLUME ["/usr/src/garie-lighthouse/reports", "/usr/src/garie-lighthouse/logs"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["npm", "start"]
