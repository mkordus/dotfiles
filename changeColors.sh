#!/bin/bash

if [ -n "$TMUX" ]; then

    tr -d ' \t' | sed -n '
    s/.*background:/\x1bPtmux;\x1b\x1b]11;\x1b\\/p
    s/.*foreground:/\x1b]10;/p
    s/.*color\([0-9][^:]*\):/\x1b]4;\1;/p
    ' | tr \\n \\a

else

    tr -d ' \t' | sed -n '
    s/.*background:/\x1b]11;/p
    s/.*foreground:/\x1b]10;/p
    s/.*color\([0-9][^:]*\):/\x1b]4;\1;/p
    ' | tr \\n \\a

fi
