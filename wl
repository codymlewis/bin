#!/bin/sh

action="$1"
shift

wl_file="$HOME/.watch_later"

case "$action" in
        dl)
                olddir=$(pwd)
                cd "$HOME/Videos" || exit
                youtube-dl "$@" -ic --add-metadata -f 'best' -a "$wl_file"
                cd "$olddir" || exit
                ;;
        v)
                q=$(printf "480\n720\nMax" | fzf)
                ([ "$q" = Max  ] &&
                        ytdl="best") ||
                        ytdl="best[height<=$q]"
                mpv --ytdl-format="$ytdl" --playlist="$wl_file"
                ;;
        add)
                echo "$@" >> "$wl_file"
                ;;
        clear)
                echo '' > "$wl_file"
                ;;
        ls)
                cat "$wl_file"
                ;;
esac
