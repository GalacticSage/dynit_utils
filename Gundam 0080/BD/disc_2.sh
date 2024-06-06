#!/bin/bash

input_file="source_rips/MOBILE SUITE GUNDAM 0080_disc2/MOBILE SUITE GUNDAM 0080_t00.mkv"

tmp_output_directory="tmp/disc2/"
output_directory="output/Gundam 0080/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

oav4="Oltre il fiume e tra gli alberi"
oav5="Dì che non è così, Bernie!"
oav6="La guerra in tasca"

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
mkvmerge -o "$output_pattern" --split chapters:6,11 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${oav4}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${oav5}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${oav6}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e04.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e05.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e06.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/