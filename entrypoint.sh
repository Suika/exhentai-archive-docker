#!/bin/sh

echo "Preparing config.json"
envsubst < /config.json | tee /var/www/exhen/config.json /var/www/exhen/www/config.json
envsubst < /sphinx.conf > /etc/sphinxsearch/sphinx.conf
envsubst < /nginx.conf > /etc/nginx/nginx.conf

echo "Rotating All Sphinx Indexes"
/usr/bin/indexer --rotate --all

supervisord -c /etc/supervisord.conf