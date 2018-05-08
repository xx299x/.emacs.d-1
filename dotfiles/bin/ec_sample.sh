#!/bin/bash

Wind_wine=`xdotool getwindowfocus -f`
sleep 0.5

if [ $(xdotool search --onlyvisible --class "wine" | grep -i $Wind_wine) ]; then
    Wind_id=$Wind_wine;
else
    Wind_id=`xdotool getactivewindow`;
    sleep 0.5
fi

if [ $(xdotool search --onlyvisible --class "llpp" | grep -i $Wind_id) ]; then
    word=$(xclip -selection primary -o | sed 's/[\"]/\\&/g')
else
    xdotool key --clearmodifiers ctrl+c
    word=$(xclip -selection clipboard -o | sed 's/[\"]/\\&/g')
fi

# run-or-raise.sh emacs

emacsclient -a '' -c -F "((name . \"ec_float\")(top . -1))" -e "(progn (add-hook 'delete-frame-functions '(lambda (frame) (write-region (current-kill 0) nil \"/tmp/eaclipboard\") (shell-command \"xclip -selection clipboard /tmp/eaclipboard &> /dev/null\") (w3m-quit 1))) (w3m-youdao-sample-sentences (substring-no-properties \"$word\")) (local-set-key (kbd \"q\") 'delete-frame))"

xdotool windowactivate --sync $Wind_id && exit 0
