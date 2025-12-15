#!/bin/sh

git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty="format:%C(yellow)%h %C(reset)%s%C(green) %d%C(blue) %an%C(reset) %cD" --exclude=refs/stash --all | sed 's/\*/●/g'
