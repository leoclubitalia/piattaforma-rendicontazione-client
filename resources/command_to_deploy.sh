filename = "portaleo-0.2.2.zip"

cp /home/debian/$filename /var/www/html
cd /var/www/html
sudo su
unzip $filename
rm -r __MACOSX/
rm $filename
#mv rendicontationplatform-0.2.1/ portaleo-flutter
nginx -t
systemctl reload nginx