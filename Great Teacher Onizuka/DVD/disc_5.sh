#!/bin/bash

input_file="source_rips/GTO_05/B1_t00.mkv"

tmp_output_directory="tmp/disc5/"
output_directory="output/GTO - GREAT TEACHER ONIZUKA/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode28="Lesson 28"
episode29="Lesson 29"
episode30="Lesson 30"
episode31="Lesson 31"
episode32="Lesson 32"
episode33="Lesson 33"
episode34="Lesson 34"
episode35="Lesson 35"

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
mkvmerge -o "$output_pattern" --split chapters:6,11,16,21,26,31,36 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode28}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode29}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode30}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode31}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode32}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode33}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode34}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e28.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e29.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e30.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e31.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e32.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e33.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e34.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e35.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/