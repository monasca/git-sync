#!/bin/sh

set -x

rsync -avz --delete --exclude '.git' /src/ /tempgit/

message=${1:-"auto"}

cd /tempgit/
ls -l
git status
git add -A
git status
git commit -m "$message"
git push origin master

exit 0
