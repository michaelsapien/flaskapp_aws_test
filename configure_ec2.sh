#system config
export PUBIP=$(curl -s ifconfig.me)
sudo apt update
sudo apt install python3 python3-pip nginx virtualenv net-tools

#app config
cd flaskapp_aws_test
virtualenv envbdmapp
source envbdmapp/bin/activate
pip install -r requirements.txt

#service config
sudo cp bdmapp.service /etc/systemd/system/
sudo systemctl enable bdmapp
sudo systemctl start bdmapp

#nginx config for reverse proxy
sudo cp bdmappnginx /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/bdmappnginx /etc/nginx/sites-enabled  # Update file name
sudo systemctl restart nginx
sudo nginx -t
sudo systemctl reload nginx
