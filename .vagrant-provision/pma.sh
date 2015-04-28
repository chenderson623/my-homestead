#!/usr/bin/env bash
echo 'Downloading PhpMyAdmin 4.4.1'
cd ~
curl -#L http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.4.1/phpMyAdmin-4.4.1-english.tar.gz -o phpmyadmin.tar.gz
mkdir phpmyadmin && tar xf phpmyadmin.tar.gz -C phpmyadmin --strip-components 1
rm phpmyadmin.tar.gz
sudo bash /vagrant/.vagrant-provision/serve.sh $1 $(pwd)/phpmyadmin