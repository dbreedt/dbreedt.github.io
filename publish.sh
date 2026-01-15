#! /usr/bin/bash

hugo --cleanDestinationDir
hugo --minify
git add *
git commit
git push
git subtree push --prefix public origin gh-pages
