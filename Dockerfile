FROM debian:8
ENTRYPOINT [ "bash", "/entrypoint.sh" ]
WORKDIR /var/www/exhen

RUN apt-get update && \
    apt-get -y install \
    php5 \
    php5-cli \
    php5-common \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-imagick \
    php5-intl \
    php5-json \
    php5-mcrypt \
    php5-memcache \
    php5-memcached \
    php5-mysql \
    php5-readline \
    mysql-client \
    unixodbc \
    libpq5 \
    memcached \
    p7zip-full \
    nginx \
    gettext-base \
    wget \
    supervisor && rm -rf /var/lib/apt/lists/* && \
    wget http://sphinxsearch.com/files/sphinxsearch_2.2.11-release-1~jessie_amd64.deb -O /tmp/sphinxsearch.deb && \
    dpkg -i /tmp/sphinxsearch.deb && rm /tmp/sphinxsearch.deb && \
    mkdir -p /var/lib/sphinxsearch/data/exhen && chown sphinxsearch:sphinxsearch -R /var/lib/sphinxsearch/data

COPY --chown=www-data:www-data /exhen /var/www/exhen/
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh config.json sphinx.conf nginx.conf /


ENV DB_HOST=mariadb \
    DB_NAME=exhen \
    DB_USER=exhen \
    DB_PASS=pass \
    DB_PORT=3306 \
    EX_READPERCENTAGE=80 \
    EX_ARCHDIR=/var/www/exhen/archive \
    EX_IMGDIR=/var/www/exhen/images \
    EX_TEMPDIR=/var/www/exhen/tmp \
    EX_VIEWTYPE=mpv \
    EX_MEMBERID=placehoder \
    EX_PASSHASH=placehoder \
    EX_ACCESSKEY=UGAY \
    EX_SK=changeme \
    EX_SP=2 \
    EX_HATHPERKS=m1.m2.m3.tf.t1.t2.t3.p1.p2.s-210aa44613 \
    SPHINX_HOST=127.0.0.1 \
    SPHINX_NAME=exhen \
    SPHINX_USER=exhen \
    SPHINX_PASS="" \
    SPHINX_PORT=9306 \
    MEMCACHED_HOST=127.0.0.1 \
    MEMCACHED_PORT=11211 \
    SUPERVISOR_PORT=9001 \
    NGINX_PORT=80 \
    DOLLAR='$' \
    TZ=Europe/London

VOLUME /var/www/exhen/images /var/www/exhen/archive /var/www/exhen/temp /var/lib/sphinxsearch/data/exhen