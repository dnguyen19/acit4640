vboxmanage() { VBoxManage.exe "$@"}

setenforce 0
sed -r -i 's/SELINUX=(enforcing|disabled)/SELINUX=permissive/' /etc/selinux/config

yum install @core
yum install epel-release
yum install vim
yum install git
yum install tcpdump 
yum install nmap-ncat
yum install curl

yum update

firewall-cmd --zone=public --add-port=22/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent

firewall-cmd --zone=public --list-all

yum install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx

yum install mariadb-server mariadb
sudo systemctl start mariadb

echo "UPDATE mysql.user SET Password=PASSWORD('P@ssw0rd') WHERE User='root';" > mariadb_security_config.sql
echo "DELETE FROM mysql.user WHERE User='';" >> mariadb_security_config.sql
echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> mariadb_security_config.sql
echo "DROP DATABASE test; DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" >> mariadb_security_config.sql

mysql -u root -p < mariadb_security_config.sql

sudo systemctl enable mariadb

yum install php php-mysql php-fpm

sed -i '763s/.*/cgi.fix_pathinfo=0/' /etc/php.ini
sed -i '12s/.*/listen = /var/run/php-fpm/php-fpm.sock' /etc/php-fpm.d/www.conf
sed -i '31s/.*/listen.owner = nobody' /etc/php-fpm.d/www.conf
sed -i '32s/.*/listen.group = nobody' /etc/php-fpm.d/www.conf
sed -i '39s/.*/user = nginx' /etc/php-fpm.d/www.conf
sed -i '41s/.*/group = nginx' /etc/php-fpm.d/www.conf

sed -i '43s/.*/index index.php index.html. index.htm;' /etc/nginx/nginx.conf
sed -i '58s/.*/location ~ \.php$ {' /etc/nginx/nginx.conf
...

echo "CREATE DATABASE wordpress;" > wp_mariadb_config.sql
echo "CREATE USER wordpress_user@localhost IDENTIFIED BY 'P@ssw0rd';" >> wp_mariadb_config.sql
echo "GRANT ALL PRIVILEGES ON wordpress.* TO wordpress_user@localhost;">> wp_mariadb_config.sql
echo "FLUSH PRIVILEDGES;" >> wp_mariadb_config.sql

