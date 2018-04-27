FROM dtfuller/stretch-slim:0.1 
USER root

# install build dependencies, get source
RUN apt-get update && apt-get install -y wget make gcc
WORKDIR /usr/local/share/
RUN wget https://ftp.postgresql.org/pub/source/v10.3/postgresql-10.3.tar.gz
RUN tar -xf ./postgresql-10.3.tar.gz
WORKDIR postgresql-10.3

# build & install 
RUN /bin/bash -c "./configure --without-readline --without-zlib \ 
        && make \
        && make install"

# setup postgres environment
RUN /bin/bash -c "useradd -m postgres \
        && mkdir -p /usr/local/pgsql/data \
        && chown postgres:postgres -R /usr/local/pgsql \
        && ln -s /usr/local/pgsql/bin/* /usr/local/bin/" 
USER postgres
WORKDIR /home/postgres

# initialize db.
EXPOSE 5432
RUN /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
ENTRYPOINT ["/usr/local/pgsql/bin/postgres", "-D", "/usr/local/pgsql/data"]
