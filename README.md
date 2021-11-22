# Install MariaDB
**Last Update**: November 22, 2021

This installer should work on any Debian based OS. This also includes Ubuntu. If it detects MariaDB or MySQL is already running on port 3306 it will abort the installation.

#### Install CURL first
```
apt-get install curl -y
```

#### Run the installer with the following command
```
bash <( curl -sSL https://raw.githubusercontent.com/unixxio/install-mariadb/main/install-mariadb.sh )
```

**Requirements**
* Execute as root

**What does it do**
* Install MariaDB from APT repository

**Important Locations**
* /root/.my.cnf (root credentials)
* /etc/mysql/my.cnf (global configuration)

#### MariaDB Configuration answers
These questions will popup during installation. For best practice use the answers below.

```
Enter current password for root (enter for none): ENTER
OK, successfully used password, moving on...

Switch to unix_socket authentication [Y/n] Y

Change the root password? [Y/n] Y

Remove anonymous users? [Y/n] Y

Disallow root login remotely? [Y/n] Y

Remove test database and access to it? [Y/n] Y

Reload privilege tables now? [Y/n] Y
```

**MariaDB (MySQL) Commands**

MariaDB status
```
systemctl status mariadb
```
MariaDB stop
```
systemctl stop mariadb
```
MariaDB start
```
systemctl start mariadb
```
MariaDB restart
```
systemctl restart mariadb
```
Check MariaDB version
```
mariadb --version
```
Login to MariaDB (without password only if ~/.my.cnf is present)
```
mariadb or mysql
```
Login to MariaDB (with password, root can be any username)
```
mariadb -p -u root
```
Show existing databases
```
SHOW DATABASES;
```
Use existing database and show tables
```
USE DATABASE example_db01;
SHOW TABLES;
```
Create database
```
CREATE DATABASE example_db01;
```
Create MariaDB (MySQL) user
```
CREATE USER 'username'@'localhost' IDENTIFIED BY 'mypassword';
CREATE USER 'username'@'127.0.0.1' IDENTIFIED BY 'mypassword';

GRANT ALL PRIVILEGES ON 'example_db01'.* TO 'username'@'localhost';
GRANT ALL PRIVILEGES ON 'example_db01'.* TO 'username'@'127.0.0.1';

FLUSH privileges;
```
Create a .my.cnf file in /home/username/.my.cnf
```
[client]
user = username
password = mypassword
```
Set correct permissions on ~/.my.cnf
```
chown -R username: /home/username/.my.cnf
```

**Tested on**
* Debian 10 Buster
* Debian 11 Bullseye

## Support
Feel free to [buy me a beer](https://paypal.me/sonnymeijer)! ;-)

## DISCLAIMER
Use at your own risk and always make sure you have backups!
