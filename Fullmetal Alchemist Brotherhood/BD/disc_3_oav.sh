#!/bin/bash

input_file="source_rips/FMA Brotherhood-D3/FMA Brotherhood-D3_t02.mkv"

tmp_output_directory="tmp/disc3/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_specials_directory="${output_directory}Specials/"

oav2="Simple People"

# Function to create directory if it doesn't exist
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Directory '$1' created."
    else
        echo "Directory '$1' already exists."
    fi
}

create_directory "$tmp_output_directory"
create_directory "$output_specials_directory"

echo "Setting forced flag for subtitles..."
mkvpropedit --edit track:4 --set flag-forced=1 "$input_file"

echo "Copying oav file..."
cp "$input_file" "${tmp_output_directory}oav2.mkv"

echo "Setting title"
mkvpropedit "${tmp_output_directory}oav2.mkv" --edit info --set "title=${oav2}"

mv "${tmp_output_directory}oav2.mkv" "${output_specials_directory}s00e02.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/