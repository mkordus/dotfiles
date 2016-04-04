#!/bin/zsh

ctags -R --fields=+aimS --languages=php -f -\
    | grep '\(c\|i\)$' \
    | sed -n '/\/\^\s*\(class\|interface\|final\|abstract\)/p' \
    > tags
