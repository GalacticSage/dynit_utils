#!/bin/bash

input_file="source_rips/FMA Brotherhood-D2/FMA Brotherhood-D2_t00.mkv"

tmp_output_directory="tmp/disk2/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode9="Ricordi artificiali"
episode10="Destinazioni separate"
episode11="Il miracolo di Rush Valley"
episode12="Uno è tutto, tutto è uno"
episode13="Le bestie di Dublith"
episode14="Coloro che si appostano sottoterra"
episode15="L'emissario dell'est"
episode16="Sulle tracce di un compagno d'armi"

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
mkvmerge -o "$output_pattern" --split chapters:6,12,18,23,29,34,40 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode9}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode10}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode11}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode12}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode13}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode14}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode15}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode16}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e09.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e10.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e11.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e12.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e13.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e14.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e15.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e16.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/