FROM dtfuller/stretch-slim:0.11

# install dependencies and utilities.
RUN apt-get update \ 
    && apt-get install -y sudo tcpdump curl wget openssl ca-certificates build-essential libffi-dev libssl-dev libpcre3 libpcre3-dev zlib1g-dev python-dev python python-setuptools;
    # pip;

# build & install ha-proxy
WORKDIR /usr/local/src/
RUN wget http://www.haproxy.org/download/1.8/src/haproxy-1.8.15.tar.gz \
    && tar xfv haproxy-1.8.15.tar.gz \
    && rm haproxy-1.8.15.tar.gz \
    && cd /usr/local/src/haproxy-1.8.15/ \
    && make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 && make install;

# create Diffie–Hellman parameters with a high-enough entropy (so far it hasn't been as time-consuming as adviced).
RUN mkdir -p /opt/certbot \
    && openssl dhparam -out /opt/certbot/dhparams.pem 2048

# install certbot (letsencrypt's certificates client)
WORKDIR /usr/local/src/
RUN git clone https://github.com/certbot/certbot.git certbot \
    && cd certbot \
    && git checkout v0.29.1;
#     && ./certbot-auto --non-interactive --dns-cloudflare;
