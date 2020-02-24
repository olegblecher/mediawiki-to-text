#!/bin/bash
copy=FALSE
filename=NULL
while read -r LINE; do
        if echo $LINE | grep -q '<title>'
        then
                copy=TRUE
                filename=$(echo $LINE | sed 's/<[\/]*title>//g' | sed 's/\///g' ).md
                touch "$filename"
        elif echo $LINE | grep -q '^\[\[Cat' && [ $copy == 'TRUE' ]
        then
                copy=FALSE
        elif [ $copy == 'TRUE' ] && echo $LINE | grep -q -v '^<.*>$'
        then
                echo "$LINE" >> "$filename"
        fi
done
