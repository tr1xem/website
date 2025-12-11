#!/usr/bin/bash

TIMESTAMP=$(date '+%Y-%m-%d %I:%M:%S %p')
zola build
cp git_files/.git.bak public/.git
cp git_files/CNAME.bak public/CNAME
cd public
git add .
git commit -m "Automated Deploy: $TIMESTAMP"
git push

cd ..
git add .
git commit -m "Automated Commit: $TIMESTAMP"
git push
