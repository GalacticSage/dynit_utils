#!/bin/bash

input_file="source_rips/GTO_06/B1_t00.mkv"

tmp_output_directory="tmp/disc6/"
output_directory="output/GTO - GREAT TEACHER ONIZUKA/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode36="Lesson 36"
episode37="Lesson 37"
episode38="Lesson 38"
episode39="Lesson 39"
episode40="Lesson 40"
episode41="Lesson 41"
episode42="Lesson 42"
episode43="Lesson 43"

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
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode36}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode37}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode38}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode39}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode40}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode41}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode42}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode43}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e36.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e37.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e38.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e39.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e40.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e41.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e42.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e43.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/