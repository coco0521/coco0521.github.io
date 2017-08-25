#!/bin/bash
#
# The script to synchronize the markdown files from external
# git repositories.
#
# Before run this script make sure that git is installed and
# added to path. And to avoid input git password it's best to
# add password to .ssh. Please refer to
# https://help.github.com/articles/generating-ssh-keys
#
# This script does two things
# 1. Update the external git repository. If not exist git clone
# the repository
# 2. Copy the corresponding site folder to the _includes folder
# of as-website.
#

# Check git is installed
if which git > /dev/null; then
	echo "Checking git is installed..."
else
  exit
fi

# Git pull as-website first
git pull

# Use ssh git url
echo "Begin to synchronize the markdown files"
AS_TOOLS_SSH_REPO="git@github.com:TIBCOSoftware/as-tools.git"
AS_SPACEBAR_SSH_REPO="git@github.com:TIBCOSoftware/as-spacebar.git"
AS_FILES_SSH_REPO="git@github.com:TIBCOSoftware/as-files.git"
AS_SIMULATOR_SSH_REPO="git@github.com:TIBCOSoftware/as-simulator.git"
AS_SPREADSHEETS_SSH_REPO="git@github.com:TIBCOSoftware/as-spreadsheets.git"
AS_DB_SSH_REPO="git@github.com:TIBCOSoftware/as-db.git"

AS_TOOLS_DIR="as-tools"
AS_SPACEBAR_DIR="as-spacebar"
AS_FILES_DIR="as-files"
AS_SIMULATOR_DIR="as-simulator"
AS_SPREADSHEETS_DIR="as-spreadsheets"
AS_WEBSITE_DIR="as-website"
AS_DB_DIR="as-db"

cd ..

# Check whether the repositories is exist, if not clone the 
# repository to current folder
function checkGitRepo ()
{
echo $1
	if [ ! -d $1"/.git/" ]
	then
  	echo $1" folder not exist"
  	git clone $2
	else
  	echo $1" folder exist"
	fi
}

echo $AS_TOOLS_DIR

checkGitRepo $AS_TOOLS_DIR $AS_TOOLS_SSH_REPO
checkGitRepo $AS_SPACEBAR_DIR $AS_SPACEBAR_SSH_REPO
checkGitRepo $AS_FILES_DIR $AS_FILES_SSH_REPO
checkGitRepo $AS_SIMULATOR_DIR $AS_SIMULATOR_SSH_REPO
checkGitRepo $AS_SPREADSHEETS_DIR $AS_SPREADSHEETS_SSH_REPO
checkGitRepo $AS_DB_DIR $AS_DB_SSH_REPO

# Git pull of exteral repositories
function updateRepo ()
{
	echo "Update "$1
	cd $1
	git pull
	cd ..
}
repos_update=($AS_TOOLS_DIR $AS_SPACEBAR_DIR $AS_FILES_DIR $AS_SIMULATOR_DIR $AS_SPREADSHEETS_DIR $AS_DB_DIR)
for i in ${repos_update[@]}; do
	updateRepo ${i}
done

# Copy latest md files to as-website/_include
DIST_ROOT_DIR=$AS_WEBSITE_DIR"/_includes/posts"
DIST_DELIMITEDFILES=$DIST_ROOT_DIR"/delimitedfiles"
DIST_JDBCDRIVER=$DIST_ROOT_DIR"/jdbcdriver"
DIST_SIMULATOR=$DIST_ROOT_DIR"/simulator"
DIST_SPACEBAR=$DIST_ROOT_DIR"/spacebar"
DIST_SPREADSHEETS=$DIST_ROOT_DIR"/spreadsheets"
DIST_DB=$DIST_ROOT_DIR"/db"

SRC_DELIMITEDFILES=$AS_FILES_DIR"/src/site"
SRC_JDBCDRIVER=$AS_TOOLS_DIR"/as-jdbcdriver/src/site"
SRC_SIMULATOR=$AS_SIMULATOR_DIR"/src/site"
SRC_SPACEBAR=$AS_SPACEBAR_DIR"/spacebar.repository/src/site"
SRC_SPREADSHEETS=$AS_SPREADSHEETS_DIR"/src/site"
SRC_DB=$AS_DB_DIR"/src/site"

modules=("DELIMITEDFILES" "JDBCDRIVER" "SIMULATOR" "SPACEBAR" "SPREADSHEETS" "DB")

# Copy the whole site folder to their corresponding dist folder
function copyMd ()
{
  if [ ! -d $2]
    then
    mkdir $2
  fi
	cp -rfv $1 $2
}

for i in ${modules[@]}; do
	src=SRC_${i}
	dist=DIST_${i}
	copyMd ${!src} ${!dist}
done

TOOLS_DIR=$AS_WEBSITE_DIR"/tools"
IMG_DELIMITEDFILES=$TOOLS_DIR"/delimitedfiles"
IMG_JDBCDRIVER=$AS_WEBSITE_DIR"/add-ons/jdbcdriver"
IMG_SIMULATOR=$TOOLS_DIR"/simulator"
IMG_SPACEBAR=$TOOLS_DIR"/spacebar"
IMG_SPREADSHEETS=$TOOLS_DIR"/spreadsheets"
IMG_DB=$TOOLS_DIR"/db"

# Copy all the assets files to the folder which will be served
# as html files, eg tools/simulator. 
# Content of md files can be included using {%include%} but other
# assets files , eg images also must be found in tools/xxx folder
# 'exclude' file defines the file formats that do not need to be 
# copied. And this is why rsync is used here.
function copyAssets ()
{
rsync -av -F --force --progress $1 $2 --exclude-from $AS_WEBSITE_DIR"/exclude"
}

for i in ${modules[@]}; do
	src=SRC_${i}
	dist=IMG_${i}
	copyAssets ${!src}"/." ${!dist}
done


