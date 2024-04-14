#!/bin/bash

input_file="source_rips/FMA Brotherhood-D8/FMA Brotherhood-D8_t00.mkv"

tmp_output_directory="tmp/disc8/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode57="Eterno riposo"
episode58="Sacrifici"
episode59="La luce perduta"
episode60="L'occhio del cielo, la porta della terra"
episode61="Colui che vorrebbe inghiottire il Fondatore"
episode62="Un feroce contrattacco"
episode63="L'altro lato del portale"
episode64="La fine del viaggio"

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

echo "Setting forced flag for subtitles..."
mkvpropedit --edit track:7 --set flag-forced=1 "$input_file"

echo "Splitting input file based on chapters..."
mkvmerge -o "$output_pattern" --split chapters:6,11,16,21,27,32,37 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode57}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode58}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode59}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode60}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode61}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode62}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode63}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode64}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e57.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e58.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e59.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e60.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e61.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e62.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e63.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e64.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/