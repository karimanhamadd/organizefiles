#!/bin/bash
echo -e ".jpg\n.gif\n.png\n.mp3\n.mp4" > notext.txt
grep -v -f notext.txt crawling_file.txt > filtered_file.txt
