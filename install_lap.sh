#!/bin/bash

# install Apache and PHP (in a loop because a lot of installs happen
# on VM init, so won't be able to grab the dpkg lock immediately)
until apt-get -y update && apt-get -y install apache2 && apt install php5 && apt install curl && apt install php7.0-cli
do
  echo "Try again"
  sleep 2
done

# write some PHP; these scripts are downloaded beforehand as fileUris
cp index.php /var/www/html/
cp composer.json /var/www/html/
cd var/www/html
curl -O http://getcomposer.org/composer.phar
chown www-data:www-data /var/www/html/*
rm /var/www/html/index.html
# restart Apache
apachectl restart
