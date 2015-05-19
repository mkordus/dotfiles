#!/bin/zsh

echo '# Most recently edited files in Vim (version 3.0)' > ~/.vim_mru_files2

tail -n+2 ~/.vim_mru_files \
    | egrep -v '^/tmp/' \
    | parallel -k -j 10 'if [ -f "{}" ]; then echo {}; fi' \
    | >> ~/.vim_mru_files2

mv ~/.vim_mru_files2 ~/.vim_mru_files

