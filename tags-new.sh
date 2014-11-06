#!/bin/zsh

ctags \
-h ".php.html.twig" -R \
--languages=PHP \
--exclude=".svn" \
--exclude=".git" \
--exclude="*/_*cache/*" \
--exclude="*app/cache*" \
--exclude="*/_*logs{0,1}/*" \
--exclude="*/_*data/*" \
--totals=yes \
--tag-relative=yes \
--PHP-kinds=+cif-jvd \
--regex-PHP="/^abstract class ([^ ]*)/\1/c/" \
--regex-PHP="/^interface ([^ ]*)/\1/c/"  \
--regex-PHP="/^trait ([^ ]*)/\1/c/" \
--regex-PHP="/(public |static |abstract |protected |private )+ function +([^ \(]*)/\2/f/" \
--fields=+l
