#!/bin/bash

input_file="source_rips/FMA Brotherhood-D4/FMA Brotherhood-D4_t00.mkv"

tmp_output_directory="tmp/disk4/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode25="Il portale oscuro"
episode26="Riunione"
episode27="La festa della soglia"
episode28="Padre"
episode29="La disperata lotta di uno stupido"
episode30="La guerra di sterminio ad Ishval"
episode31="La promessa da 520 cents"
episode32="Il figlio del Comandante supremo"

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
mkvmerge -o "$output_pattern" --split chapters:6,11,17,23,29,35,41 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode25}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode26}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode27}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode28}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode29}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode30}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode31}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode32}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e25.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e26.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e27.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e28.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e29.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e30.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e31.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e32.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/