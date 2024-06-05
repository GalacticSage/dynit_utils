#!/bin/bash

input_file="source_rips/MOBILE SUITE GUNDAM 0080_disc1/MOBILE SUITE GUNDAM 0080_t00.mkv"

tmp_output_directory="tmp/disc1/"
output_directory="output/Gundam 0080/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

oav1="Quante miglia per il campo di battaglia?"
oav2="Riflesso in occhi castani"
oav3="E alla fine dell'arcobaleno?"

# Function to create directory if it doesn't exist
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Directory '$1' created."
    else
        echo "Directory '$1' already exists."
    fi
}

echo "Creating directories..."
create_directory "$tmp_output_directory"
create_directory "$output_directory"
create_directory "$output_season_directory"

echo "Unselecting forced flag for subtitles..."
mkvpropedit --edit track:7 --set flag-forced=1 "$input_file"

echo "Splitting input file based on chapters..."
mkvmerge -o "$output_pattern" --split chapters:7,12 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${oav1}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${oav2}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${oav3}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e01.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e02.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e03.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/