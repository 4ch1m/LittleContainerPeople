FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install --no-install-recommends --yes cron \
                                                  procps \
                                                  wget \
                                                  gnupg \
                                                  nodejs \
                                                  npm

# puppeteer dependencies ...
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' && \
    apt-get update && \
    apt-get install --no-install-recommends --yes google-chrome-stable \
                                                  fonts-ipafont-gothic \
                                                  fonts-wqy-zenhei \
                                                  fonts-thai-tlwg \
                                                  fonts-kacst \
                                                  fonts-freefont-ttf \
                                                  libxss1 && \
    rm -rf /var/lib/apt/lists/*

ARG APPNAME=lcp_careservice

RUN echo "*/15 * * * * npm --prefix /${APPNAME} start > /proc/1/fd/1 2>&1" > /etc/cron.d/${APPNAME} && \
    crontab /etc/cron.d/${APPNAME}

WORKDIR /${APPNAME}
COPY package.json .
COPY *.js ./
RUN npm install

CMD ["cron", "-f"]
