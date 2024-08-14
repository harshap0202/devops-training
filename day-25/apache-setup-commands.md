**Installing Apache**
```bash
sudo apt-get update
sudo apt-get install apache2 -y 
```

**Configuring index.html page**
```bash
sudo mkdir -p /var/www/html/web
sudo nano /var/www/html/web/index.html
```

**Updating apache config file**
```bash
cd /etc/apache2
cd sites-available
sudo cp 000-default.conf web.conf
sudo nano web.conf
```

**Restarting Apache Service**
```bash
sudo a2dissite 000-default.conf
sudo a2ensite web.conf
sudo service apache2 restart
```