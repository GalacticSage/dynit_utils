#!/bin/bash

input_file="source_rips/FMA Brotherhood-D5/FMA Brotherhood-D5_t00.mkv"

tmp_output_directory="tmp/disc5/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode33="La parete nord di Briggs"
epsiode34="La regina di ghiaccio"
episode35="La forma di questo Stato"
episode36="Ritratto di famiglia"
episode37="Il primo homunculus"
episode38="Conflitto a Baschool"
episode39="Un sogno ad occhi aperti"
episode40="Il piccolo uomo nell'ampolla"

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
mkvmerge -o "$output_pattern" --split chapters:7,12,17,24,29,35,40 "$input_file"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode33}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode34}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode35}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode36}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode37}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode38}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode39}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode40}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e33.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e34.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e35.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e36.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e37.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e38.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e39.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e40.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/