#!/bin/sh 
d=$(date +'%Y-%m-%d %I:%M:%S %p')
song=$(cmus_song)
echo "$song\t$d"
