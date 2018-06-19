FROM dtfuller/stretch-slim:0.1 
USER root

RUN apt-get update && apt-get install -y apache2 apache2-bin apache2-dbg libapache2-mod-php composer \
    php php-common php-db php-cli php-mysql php-xml mysql-client lynx

RUN mkdir -p /var/log/apache2/ \
        && touch /var/log/apache2/error.log \
        && rm /var/log/apache2/error.log \
        && ln -s /dev/stdout /var/log/apache2/error.log

RUN useradd -m www
RUN mkdir -p /home/www/html && chown -R www:www /home/www/html 
RUN mkdir -p /var/log/apache2
RUN chmod 755 /var/log/apache2

ENV APACHE_RUN_DIR="/home/www/html"
ENV APACHE_RUN_USER=www
ENV APACHE_RUN_GROUP=www
ENV APACHE_LOG_DIR=/var/log/apache2/
ENV APACHE_PID_FILE="/home/www/apache.pid"

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN /bin/bash -c "cd /etc/apache2/sites-enabled && \
                    a2dissite * && \
                    cd /etc/apache2/sites-available && \ 
                    a2ensite *"

EXPOSE 80 443
ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND", "-k", "start"]
