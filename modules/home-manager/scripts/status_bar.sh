#!/bin/sh 
d=$(date +'%Y-%m-%d %I:%M:%S %p')
song=$(~/.local/bin/cmus_song)
echo "$song\t$d"
