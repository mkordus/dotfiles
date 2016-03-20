#!/bin/zsh

RED=`echo -e '\033[31m'`
GREEN=`echo -e '\033[32m'`
MAGENTA=`echo -e '\033[35m'`
BLUE=`echo -e '\033[34m'`
YELLOW=`echo -e '\033[33m'`
CYAN=`echo -e '\033[36m'`
UNDERLINE=`echo -e '\033[4m'`
NORMAL=`echo -e '\033[0m'`

tee \
    | grep '\(c\|i\)$' \
    | sed -n '/\/\^\s*\(class\|interface\|final\|abstract\)/p' \
    | sed 's#^[^\t]*\t\([^\t]\+\)\t/^\s*\([^$]\+\)\$/;"\s*\(\w\)$#\2\t\1#' \
    | sed 's#^abstract class#a #I' \
    | sed 's#^final class#f #I' \
    | sed 's#^class#c #I' \
    | sed 's#^interface#i #I' \
    | sed 's# implements # im #gI' \
    | sed 's# extends # ex #gI' \
    | sed 's#\\\\#\\#g' \
    | sed 's#\t#          #g' \
    | sed "s# ex # ${YELLOW}ex${NORMAL} #g" \
    | sed "s# im # ${GREEN}im${NORMAL} #g" \
    | sed "s#^\(\w\s\+\)\(\w\+\)#\1${BLUE}\2${NORMAL}#"

    # | column -t -s $'\t' \
