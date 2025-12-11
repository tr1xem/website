#!/usr/bin/bash

$date=$(date '+%Y-%m-%d %I:%M:%S %p')
zola build
cp git_files/.git public/.git
cp git_files/CNAME public/CNAME
cd public
git add .
git commit -m "Automated Deploy: $date"
git push

cd ..
git add .
git commit -m "Automated Commit: $date"
git push
