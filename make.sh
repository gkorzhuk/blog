#!/bin/bash

(cd static/gallery/ && sigal build)

hugo --buildDrafts

rsync -av Docs/ ../gkorzhuk.github.io/

(cd ../gkorzhuk.github.io/ && git pull && git add --all && git commit -m "New deploy: `date +'%Y-%m-%d'`" && git push -u origin master)
