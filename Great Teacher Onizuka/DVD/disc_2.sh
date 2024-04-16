#!/bin/bash

input_file="source_rips/GTO_02/B1_t00.mkv"

tmp_output_directory="tmp/disc2/"
output_directory="output/GTO - GREAT TEACHER ONIZUKA/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode7="Lesson 7"
episode8="Lesson 8"
episode9="Lesson 9"
episode10="Lesson 10"
episode11="Lesson 11"
episode12="Lesson 12"
episode13="Lesson 13"

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
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode7}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode8}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode9}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode10}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode11}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode12}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode13}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e07.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e08.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e09.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e10.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e11.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e12.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e13.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/