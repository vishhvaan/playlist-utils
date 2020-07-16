#!/bin/bash
source "$(cd "$(dirname "$0")" && pwd)/"folder_locations
rm -rf -- "$playlistdir"/*/
mkdir "$playlistdir"/m3u8_files
cp "$exportedplaylists"/*.m3u8 "$playlistdir"/m3u8_files/

rm "${playlistdir}/m3u8_files/All Music.m3u8"

for i in "${playlistdir}/m3u8_files/"*.m3u8; do
 sed -i -e 's/\r$//' -e 's/\\/\//g' -e "s=${winelibrarydir}=../../..=g" -e '1d' "$i"
 pldir="${playlistdir}/$(echo ${i##*/} | sed -e "s=.m3u8==")"
 mkdir -p "$pldir"

 while read p; do
  slin="$p"
  artalb="$(echo ${p%/*} | sed -e "s=../../../Library/==" -e "s=/=|=")"
  slout="${pldir}/[${artalb}] ${p##*/}"
  #slout="$pldir"/"${p##*/}"
  ln -s "$slin" "$slout"
  #echo "$slout"
 done < "$i"

 sed -i -e "s=../../../Library=/music=g" "$i"
 mv "$i" "${i%?}"
done

rm -rf "$exportedplaylists"/*
cp -R "$playlistdir" "$exportedplaylists"/Backup
