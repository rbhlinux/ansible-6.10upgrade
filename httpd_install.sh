#!/bin/sh
#remember to open port 80 on nsg
sudo yum install httpd  -y
sudo cat << "EOF" >> /etc/httpd/conf/httpd.conf
<VirtualHost *:80>
ServerName 127.0.0.1
DocumentRoot /var/www/html
Alias /repos "/var/www/html/repos/"
<Directory "/var/www/html/repos">
Options +Indexes
AllowOverride None
Order allow,deny
Allow from all
</Directory>
</VirtualHost>
EOF


sudo mkdir -p /var/www/html/repos
sudo cp CentOS-Base.repo  /var/www/html/repos/CentOS-Base.repo
sudo cp epel.repo /var/www/html/repos/epel.repo
sudo cat << 'EOF' > /var/www/html/index.html
<html>
<body>
<h2>Hello Welcome to TesT in Meijer</h2>
</body>
</html>
EOF


sudo service httpd start >> /dev/null

if (( $( ps aux | grep httpd | wc -l ) > 1  ))
then
echo "HTTP configured and started"
else
echo "HTTP failed to start"
fi


sudo firewall-cmd --add-port=80/tcp --zone=public --permanent
sudo firewall-cmd --reload
sudo service httpd restart
