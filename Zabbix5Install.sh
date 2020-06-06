#Ubuntu20 server üzerine Zabbix 5 kurulumu
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+$(lsb_release -sc)_all.deb
dpkg -i zabbix-release_5.0-1+$(lsb_release -sc)_all.deb
apt update
apt -y install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent


#Bu yapılandırma örneğinde Veritabanı ve Zabbix için strongPassword şifresini kullanıyorum.

#Veritabanı Yapılandırması
mysql_secure_installation

#Aşağıda set root password Y seçeneğinden sonra strongPassword ifadesi girilerek veritabanı root kullanıcısının şifresi yapılandırılır.
Enter current password for root (enter for none): Press the Enter
Set root password? [Y/n]: Y
New password: <Enter root DB password>
Re-enter new password: <Repeat root DB password>
Remove anonymous users? [Y/n]: Y
Disallow root login remotely? [Y/n]: Y
Remove test database and access to it? [Y/n]:  Y
Reload privilege tables now? [Y/n]:  Y

#Veritabanı üzerinde database oluşturma
#Veritabanı ismi zabbix ve şifresi zabbixDBpass

mysql -uroot -p'strongPassword' -e "create database zabbix character set utf8 collate utf8_bin;"
mysql -uroot -p'strongPassword' -e "grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbixDBpass';"

mysql -uroot -p'strongPassword' zabbix -e "set global innodb_strict_mode='OFF';"
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p'zabbixDBpass' zabbix
mysql -uroot -p'strongPassword' zabbix -e "set global innodb_strict_mode='ON';"

#Zabbix_server.conf dosyası nano ile açılır herhangi bir alana DBPassword=zabbixDBpass satırı eklenir.
nano /etc/zabbix/zabbix_server.conf

#Zabbix Server ve Ajanı başlatılır
systemctl restart zabbix-server zabbix-agent 
systemctl enable zabbix-server zabbix-agent

Zabbix php configure dosyası açılır aşağıdaki yorum satırı aktif hale getirilir.Aşağıdaki şekilde yazılarak kayıt edilir.
nano /etc/zabbix/apache.conf
“# php_value date.timezone Europe/Riga”
php_value date.timezone Europe/Istanbul

Web Server Yeniden başlatma
systemctl restart apache2
systemctl enable apache2

http://server_ip/zabbix  adresi ile bağlantı sağlanır. Zabbix şifreniz zabbixDBpass 

#İşlem sonrası Admin/Zabbix ile giriş yapılır.
