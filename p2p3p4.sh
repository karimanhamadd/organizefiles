#!/bin/bash
filename="filtered_file.txt"
base_direc="web_server"
mkdir -p "$base_direc"

while IFS= read -r line
do 
    removal=$(echo "$line" | sed 's~^https\?://~~')
    if [[ "$removal" == *\/ ]]
    then 
        directory="$base_direc/$removal"
        file="index.html"
    else
        file=$(echo "$line" | sed 's/.*\///')
        directory="$base_direc/${removal%/*}"

	extensions=(".php" ".py" ".perl")
        for extension in "${extensions[@]}"
        do
            if [[ $file == *"$extension" ]]
            then
                file="${file}${extension}.html"
                break
            fi
        done
    fi 

    mkdir -p "$directory"
    curl -o "$directory/$file" "$line"

done < "$filename"
