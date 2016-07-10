#!/bin/bash
for dir in /mnt/*/
do
    dir=${dir%*/}
    echo tree -anh --du --charset=ascii --prune -o ${dir##*/}-$(date +%Y%m%d).txt $dir/
    tree -anh --du --charset=ascii --prune -o ${dir##*/}-$(date +%Y%m%d).txt $dir/
    echo ${dir##*/}
done
