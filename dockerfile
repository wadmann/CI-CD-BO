FROM vuejs/ci

EXPOSE 8080

COPY . .

RUN npm install && npm cache verify

RUN su -c 'echo "deb http://deb.debian.org/debian jessie-backports main" >> /etc/apt/sources.list'

RUN rm -rf /var/lib/apt/lists/* &&\
    apt-get --yes update &&\
    apt install --yes -t jessie-backports  openjdk-8-jre-headless ca-certificates-java

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' &&\
    apt-get update && apt-get -y install google-chrome-stable

RUN cp /postcss.config.js /node_modules/vuetify/dist/