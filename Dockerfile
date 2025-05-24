FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-php php php-gd \
    build-essential libgd-dev openssl libssl-dev unzip wget curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd nagios && \
    usermod -a -G nagios www-data && \
    mkdir -p /opt/nagios && \
    cd /tmp && \
    wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz && \
    tar zxvf nagios-4.4.6.tar.gz && \
    cd nagios-4.4.6 && \
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled && \
    make all && \
    make install && \
    make install-init && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

RUN a2enmod cgi

EXPOSE 80

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

