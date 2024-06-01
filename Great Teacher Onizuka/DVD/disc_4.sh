#!/bin/bash

input_file="source_rips/GTO_04/B1_t00.mkv"

tmp_output_directory="tmp/disc4/"
output_directory="output/GTO - GREAT TEACHER ONIZUKA/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode21="Lesson 21"
episode22="Lesson 22"
episode23="Lesson 23"
episode24="Lesson 24"
episode25="Lesson 25"
episode26="Lesson 26"
episode27="Lesson 27"

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
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode21}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode22}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode23}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode24}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode25}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode26}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode27}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e21.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e22.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e23.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e24.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e25.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e26.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e27.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/