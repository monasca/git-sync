#!/bin/sh

set -x

IP_ADDRESS=$(hostname -i)
export IP_ADDRESS
python /template.py /etc/gitweb.conf.j2 /etc/gitweb.conf

addgroup -S http
adduser -G http -S http

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

mkdir -p /git/sync.git
cd /git/sync.git
git init --bare
touch git-daemon-export-ok
echo "git-sync automatic repository" > description

mkdir /tempgit
cd /tempgit/
git init
git remote add origin file:///git/sync.git/
