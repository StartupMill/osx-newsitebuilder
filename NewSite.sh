# By Toby Allen
# 2017

#!/bin/sh

PATH_SITES="/Users/$USR_CONF/sites/www"
PATH_HOST="/private/etc"
PATH_CONF="/private/etc/apache2/users"
USR_CONF="OS X User Name"
USR_EMAIL="user@test.com"

echo "########################################################################"
echo "Awesome New Website Creator"
echo "--------------------------"
echo "Hello, world $PATH_HOST!"

echo "########################################################################"
printf "Name of the new site: "
read NAME
cd $PATH_SITES
mkdir $NAME
chown $USR_CONF $NAME
chmod 777 $NAME
echo " "
echo "Folder $NAME created in $PATH_SITES"
echo "########################################################################"

echo "CONFIG"
cd $PATH_CONF
echo $PATH_CONF

echo " " >> $USR_CONF.conf
echo "# $NAME" >> $USR_CONF.conf

echo "<VirtualHost *:80>" >> $USR_CONF.conf
echo "    ServerAdmin $USR_EMAIL" >> $USR_CONF.conf
echo "    DocumentRoot \"/Users/$USR_CONF/Sites/www/$NAME/\" " >> $USR_CONF.conf
echo "    ServerName $NAME.dev " >> $USR_CONF.conf
echo "    ServerAlias $NAME.dev " >> $USR_CONF.conf
echo "    ErrorLog \"/private/var/log/apache2/$NAME.dev-error_log\" " >> $USR_CONF.conf
echo "    CustomLog \"/private/var/log/apache2/$NAME.dev-access_log\" common " >> $USR_CONF.conf
echo "</VirtualHost>" >> $USR_CONF.conf

echo "CONFIG: DONE"

echo "--------------------------"

cd $PATH_HOST
echo $PATH_HOST

# echo " " >> hosts
echo "127.0.0.1	$NAME.dev $NAME.dev" >> hosts
echo "HOST Settings: DONE"
echo "Restart Apache? y or n "
printf "Answer: "
read A
if [ "$A" = "y" ] ; then
    sudo apachectl restart
    echo "Restarting Apache"
else
    echo "Not Restarting Apache"
fi
echo "All Done - Now go test"
echo "--------------------------"
