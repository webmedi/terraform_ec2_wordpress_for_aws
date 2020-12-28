#!/bin/bash

yum -y update
amazon-linux-extras install php7.2 -y
yum -y install mysql httpd php-mbstring php-xml

wget http://ja.wordpress.org/latest-ja.tar.gz -P /tmp/
tar zxvf /tmp/latest-ja.tar.gz -C /tmp
cp -r /tmp/wordpress/* /var/www/html/
chown apache:apache -R /var/www/html

systemctl enable httpd.service
systemctl start httpd.service
