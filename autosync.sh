#!/bin/bash
#
# The script is used to sync staging server automatically
# which will be called by Jenkins periodly. 
# Usage: 
#  1)autosync.sh
#    Update all git repositories, push changes to as-website 
#    and sync staging server
#  2)autosync.sh commit
#    Update all git repositories and push changes to as-website
#    Do not sync staging server 
#  3)autosync.sh sync
#    Update all git repositories. if there are changes commit 
#    the code and sync staging server. if no changes just 
#    build jekyll and sync staging server


# Sync all the repositories 
./syncmd.sh

GIT_STATUS_FILE="gitstatus"

# The function to delete exist file
function deleteExistFile()
{

if [ -a $1 ]
  then
  # remove this file
  rm -f $1
fi

}

deleteExistFile $GIT_STATUS_FILE

# export the git status to status file
# 'gitstatus' file stores the output of "git status"
git status -s > $GIT_STATUS_FILE

# 'mdlist' file stores the full path of files which need to be
# checked in. the format of this file is one file in one line
MD_FILE_LIST="mdlist"
deleteExistFile $MD_FILE_LIST

# grap the md modification path 
# Now only md/xml/svg/gif/png and folder are extracted
# Here we can use '>' to pipe the output of 'git status' to awk
# but I want to save middle result for checking purpose
awk '/(\.md|\.xml|\.svg|\.gif|\.png|\/)/ {print $2} ' $GIT_STATUS_FILE > $MD_FILE_LIST

# check the mdlist file to see whether we need to lauch the 
# the script to sync remote server

SITE_TAR_GZ_FILE="site.tar.gz"
EC2_USER="tdo"
EC2_URL="ec2-54-197-207-111.compute-1.amazonaws.com"

# Regenerate the static html files, compress the '_site' folder and
# copy the tar file to remote server. when it is done execute the
# 'remoteScript.sh' to sync remote server
function buildAndScp () 
{
# before build remove site.tar.gz

deleteExistFile $SITE_TAR_GZ_FILE

jekyll build
if [ -d _site ]
  then
  tar -czf $SITE_TAR_GZ_FILE _site
  scp -i ../test-activespaces.pem $SITE_TAR_GZ_FILE $EC2_USER@$EC2_URL:/tmp/website &
  sleep 30
  ssh -i ../test-activespaces.pem $EC2_USER@$EC2_URL 'bash -s' < ./remoteScript.sh
fi
}

function gitAdd ()
{
git add $1
}

# Check in code automatically
function pushCode ()
{
local c=0
while read -r line
do
  myarray[c]=$line
  c=$((c+1))
done < mdlist

for i in ${!myarray[@]}; do
  echo "No. "$i" change is "${myarray[i]}
  git add ${myarray[i]}
done

git commit -m "Update md files.[by script]"
git push origin gh-pages

}

if [ -s $MD_FILE_LIST ]
  then
  # push code to github
  echo "...commit code"
  pushCode

  if [ "$1" == "commit" ]
    then
    exit 1
  fi

  # lauch the script
  echo "...build static html files and transfer site to remote server"
  buildAndScp

else
  echo "no md is updated"
  if [ "$1" == "sync" ]
    then
    echo "...build site and sync remote server"
    buildAndScp
  fi
fi

