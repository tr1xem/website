#!/usr/bin/bash

TIMESTAMP=$(date '+%Y-%m-%d %I:%M:%S %p')
zola build --output-dir publish_tmp --force
rsync -av --delete --exclude='.git' --exclude='CNAME' publish_tmp/ public/
cd public
git pull --rebase
git add .
git commit -m "Automated Deploy: $TIMESTAMP"
git push

cd ..
git add .
git commit -m "Automated Commit: $TIMESTAMP"
git push
