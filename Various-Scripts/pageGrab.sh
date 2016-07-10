#!/bin/bash
for i in {1..58}
do
    echo item: $i
    wget "https://assets.documentcloud.org/documents/2761023/pages/Report-on-U-S-Customs-and-Border-Protection-p"$i"-normal.gif"
done

