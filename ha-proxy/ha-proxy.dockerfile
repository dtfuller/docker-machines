FROM dtfuller/stretch-slim:0.11

WORKDIR /usr/local/src/
RUN apt-get update \ 
    && apt-get install -y wget make gcc openssl libssl-dev libpcre3 libpcre3-dev zlib1g-dev \
    && wget http://www.haproxy.org/download/1.8/src/haproxy-1.8.15.tar.gz \
    && tar xfv haproxy-1.8.15.tar.gz ;
    # "&& rm haproxy-1.8.15.tar.gz";

WORKDIR /usr/local/src/haproxy-1.8.15/
RUN make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 && make install;