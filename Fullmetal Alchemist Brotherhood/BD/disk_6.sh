#!/bin/bash

input_file="source_rips/FMA Brotherhood-D6/FMA Brotherhood-D6_t00.mkv"

tmp_output_directory="tmp/disk6/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode41="Inferno"
episode42="I segni del contrattacco"
episode43="Il morso della formica"
episode44="Nel pieno delle forze"
episode45="Il giorno della promessa"
episode46="L'ombra degli inseguitori"
episode47="Il messaggero dell'oscurità"
episode48="Giuramento nei sotterranei"

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
mkvmerge -o "$output_pattern" --split chapters:6,12,19,25,31,37,42 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode41}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode42}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode43}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode44}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode45}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode46}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode47}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode48}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e41.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e42.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e43.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e44.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e45.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e46.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e47.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e48.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/