#!/bin/bash


sed -i 's/bind-address            = 127.0.0.1/bind-address  = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf


/etc/init.d/mariadb start ; sleep 0.5

mysql -u root << end
CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
end

/etc/init.d/mariadb stop ; sleep 0.5

mysqld_safe 
