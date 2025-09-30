#!/bin/sh

echo "Preparing config files"
envsubst < /config.json | tee /var/www/exhen/config.json > /var/www/exhen/www/config.json
envsubst < /sphinx.conf > /etc/sphinxsearch/sphinx.conf
cat /nginx.conf > /etc/nginx/nginx.conf

echo "Rotating all Sphinx Indexes"
/usr/bin/indexer --rotate --all

echo "Fixing folder permissions"
chown sphinxsearch:sphinxsearch -R /var/lib/sphinxsearch/data
chown www-data:www-data /var/www/exhen/images /var/www/exhen/tmp
find . -type d -exec chown www-data:www-data "{}"\;

echo "Starting supervisor"
supervisord -c /etc/supervisord.conf