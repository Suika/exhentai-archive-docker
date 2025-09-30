# Exhentai-Archive on Docker

A single container to run [ExHentai-Archive](https://github.com/Suika/ExHentai-Archive).
DB needs to be initialized by hand, just use [db.sql](https://github.com/Sn0wCrack/ExHentai-Archive/blob/master/db.sql)

The ENVs with __REPLACEME__ and the DB part needs the right parameters. Most you can get out of the cookies.
SP is your viewing profile (create a second profile and you will get the key in the cookie), 
the system needs the "Front Page Settings" to be set to Minimal if you want to use the feed feature.

__EX_ACCESSKEY__ is the key that will be used by the [userscript.user.js](https://github.com/Sn0wCrack/ExHentai-Archive/blob/master/userscript.user.js)


Volumes:

- /var/www/exhen/images:     Thumb of first image in the archive
- /var/www/exhen/archive:    Location where the archive and pages will be saved
- /var/www/exhen/tmp:        TMP files
- /var/lib/sphinxsearch/data/exhen: sphinx data

Compose:
```
 services:
  exhen-db:
    image: mariadb:10.3
    container_name: exhen-db
    command: [ '--wait_timeout=28800', ]
    ports:
      - 3306:3306
    volumes:
      - ./exhen-db:/var/lib/mysql
    restart: always
  exhen:
    image: suika/exhentai-archive:latest
    container_name: exhen
    restart: unless-stopped
    ports:
      - 6767:6767
    tmpfs:
      - /var/www/exhen/tmp
    volumes:
      - ./exhen/sphinx:/var/lib/sphinxsearch/data/exhen
      - ./exhen/images:/var/www/exhen/images
      - ./exhen/archive:/var/www/exhen/archive
    environment:
      - DB_HOST=exh-db
      - DB_NAME=exhen
      - DB_USER=exhen
      - DB_PASS=exhen
      - EX_ACCESSKEY=UGANDA
      - NGINX_PORT=6767
      - EX_MEMBERID=you
      - EX_PASSHASH=wish
      - EX_IGNEOUS=suuuuure
      - EX_SK=hah
      - EX_SP=2
      - TZ=Europe/London
```

ENV:
```
DB_HOST=mariadb
DB_NAME=exhen
DB_USER=exhen
DB_PASS=pass
DB_PORT=3306

EX_READPERCENTAGE=80
EX_ARCHDIR=/var/www/exhen/archive
EX_IMGDIR=/var/www/exhen/images
EX_TEMPDIR=/var/www/exhen/tmp
EX_VIEWTYPE=mpv
EX_MEMBERID=REPLACEME
EX_PASSHASH=REPLACEME
EX_ACCESSKEY=REPLACEME
EX_IGNEOUS=REPLACEME
EX_SK=REPLACEME
EX_SP=REPLACEME
EX_HATHPERKS=m1.m2.m3.tf.t1.t2.t3.p1.p2.s-210aa44613

SPHINX_HOST=127.0.0.1
SPHINX_NAME=exhen
SPHINX_USER=exhen
SPHINX_PASS=""
SPHINX_PORT=9306

MEMCACHED_HOST=127.0.0.1
MEMCACHED_PORT=11211

SUPERVISOR_PORT=9001
NGINX_PORT=80
DOLLAR='$'
TZ=Europe/London
```

```
DOCKER_BUILDKIT=1 docker build -t suika/exhentai-archive:latest https://github.com/Suika/exhentai-archive-docker.git
```