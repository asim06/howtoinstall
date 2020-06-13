#Zabbix5 Agent kurulumu Pardus 19 için yapılacaktır. Debian 10/9 ve diğer Parduslar dağıtımlarında kullanabilirsiniz
wget https://repo.zabbix.com/zabbix/5.0/debian/pool/main/z/zabbix-release/zabbix-release_5.0-1+buster_all.deb
dpkg -i zabbix-release_5.0-1+buster_all.deb 

apt update

apt install zabbix-agent


#Zabbix yapılandırma Dosyası içeresinde yapılacaklar;
nano /etc/zabbix/zabbix_agentd.conf 

Server= Zabbix sunucu ip adresi örnek
Server= 192.168.1.9

ServerActive= Zabbix sunucu ip adresi
ServerActive=192.168.1.9

Hostaname=bilgisayarisminiz
Hostname=Pardus10

Örnekte olduğu gibi değiştirilmelidir.





systemctl enable zabbix-agent
systemctl start zabbix-agent
systemctl status zabbix-agent
