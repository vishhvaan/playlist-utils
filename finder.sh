#! /bin/bash
source "$(cd "$(dirname "$0")" && pwd)/"folder_locations 
read -p "What do you want to find? :" search
 
grep -n $search "${playlistdir}/m3u8_files/"*.m3u > search_results.txt
cat search_results.txt

#read -p "Exit?" search
