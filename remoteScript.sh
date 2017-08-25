#!/bin/bash
# This script is used to update the site in Apache
# http server

TEMP_DIR="/tmp/website"
SITE_FOLDER="_site"
SITE_TAR_GZ_FILE="site.tar.gz"
BACKUP_SITE_TAR_GZ_FILE="site_bak.tar.gz"
APACHE_DIR="/opt/products/apache2"
HTDOCS_FOLDER="htdocs"

function updateSite ()
{

#tar -xfz $SITE_TAR_GZ_FILE
cd $APACHE_DIR

# backup

if [ -f $BACKUP_SITE_TAR_GZ_FILE ]
  then
  rm -f $BACKUP_SITE_TAR_GZ_FILE
fi

echo "compress htdocs"

# Compress the current working files to backup
tar -czf $BACKUP_SITE_TAR_GZ_FILE htdocs

# copy the new site tar file to apache folder
cp -f $TEMP_DIR"/"$SITE_TAR_GZ_FILE ./

rm -rf $HTDOCS_FOLDER

# Uncompress the tar file and rename to htdocs
tar -xzf $SITE_TAR_GZ_FILE
mv _site $HTDOCS_FOLDER

echo "restart apache server"
sudo service httpd restart
}

cd $TEMP_DIR

if [ -f $SITE_TAR_GZ_FILE ]
  then
  updateSite
fi

