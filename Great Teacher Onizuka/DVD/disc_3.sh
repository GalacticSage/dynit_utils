#!/bin/bash

input_file="source_rips/GTO_03/B1_t00.mkv"

tmp_output_directory="tmp/disc3/"
output_directory="output/GTO - GREAT TEACHER ONIZUKA/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode14="Lesson 14"
episode15="Lesson 15"
episode16="Lesson 16"
episode17="Lesson 17"
episode18="Lesson 18"
episode19="Lesson 19"
episode20="Lesson 20"

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
mkvpropedit --edit track:4 --set flag-forced=0 "$input_file"

echo "Splitting input file based on chapters..."
mkvmerge -o "$output_pattern" --split chapters:6,11,16,21,26,31 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode14}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode15}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode16}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode17}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode18}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode19}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode20}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e14.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e15.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e16.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e17.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e18.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e19.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e20.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/