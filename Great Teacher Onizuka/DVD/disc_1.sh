#!/bin/bash

input_file="source_rips/GTO_01/B1_t00.mkv"

tmp_output_directory="tmp/disc1/"
output_directory="output/GTO - GREAT TEACHER ONIZUKA/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode1="Lesson 1"
episode2="Lesson 2"
episode3="Lesson 3"
episode4="Lesson 4"
episode5="Lesson 5"
episode6="Lesson 6"

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
mkvmerge -o "$output_pattern" --split chapters:8,13,18,23,28 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode1}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode2}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode3}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode4}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode5}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode6}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e01.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e02.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e03.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e04.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e05.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e06.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/