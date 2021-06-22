# Update system
sudo apt-get update
sudo apt upgrade

# Install Nginx
sudo apt install nginx

# Allow Nginx to run in background and on startup
sudo systemctl start nginx
sudo systemctl enable nginx

# Create dummy application
sudo mkdir -p /var/www/www.domain.tld/html
sudo chmod -R 755 /var/www/www.domain.tld
echo "<html>
    <head>
        <title>Welcome to www.domain.tld!</title>
    </head>
    <body>
        <h1>Success!  The www.domain.tld server block is working!</h1>
    </body>
</html>" > /var/www/www.domain.tld/html/index.html

# Add block for application
sudo echo "server {
    listen 80;
    listen [::]:80;

    root /var/www/www.domain.tld/html;
    index index.html index.htm index.nginx-debian.html;

    server_name www.domain.tld;

    location / {
        #try_files $uri $uri/ =404;
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}" > /etc/nginx/sites-available/www.domain.tld

# Create a linking for block in site-enabled
sudo ln -s /etc/nginx/sites-available/www.domain.tld /etc/nginx/sites-enabled/

# Reload Nginx configuration of nginx to reflect changes
sudo systemctl restart nginx
sudo systemctl reload nginx

# Update firewall Details
sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw delete allow 'Nginx HTTP'
sudo ufw enable

# Installing Cerbot
sudo apt-get remove certbot
sudo snap install --classic certbot

# Allow Cerbot to generate and configure certificate
sudo certbot --nginx -d www.domain.tld