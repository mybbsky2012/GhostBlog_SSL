#!/bin/bash

echo "This will restart your nodejs services!"

#stop nodejs with forever
forever stop /var/www/ghost/index.js

#download the latest version of Ghost
cd /var/www/ghost
tar zcvf content.tar.gz content
mv content.tar.gz ../
mv config.js ../
cd .. && rm -rf ghost
curl -L https://ghost.org/zip/ghost-latest.zip -o ghost.zip
unzip -uo ghost.zip -d ghost
rm -rf ghost.zip
chmod 755 /var/www/ghost
cd ghost

#install the latest Ghost version
npm install --production
rm -rf /var/www/ghost/content
mv ../content.tar.gz . && tar zxvf content.tar.gz && rm content.tar.gz
rm /var/www/ghost/config.example.js && mv ../config.js .

#start nodejs and your Ghost blog
forever start /var/www/ghost/index.js

echo "Your update has been done!Enjoy the latest version"
