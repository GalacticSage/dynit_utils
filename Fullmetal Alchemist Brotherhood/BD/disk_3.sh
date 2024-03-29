#!/bin/bash

input_file1="source_rips/FMA Brotherhood-D3/FMA Brotherhood-D3_t00.mkv"
#input_file2="source_rips/FMA Brotherhood-D3/FMA Brotherhood-D3_t02.mkv"

tmp_output_directory="tmp/disk3/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"
#output_specials_directory="${output_directory}Specials/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode17="Fiamme spietate"
epsiode18="Il palmo della mano arrogante di un piccolo essere umano"
episode19="La morte dell'immortale"
episode20="Il padre di fronte alla tomba"
episode21="Anticipo del buffone"
episode22="Quelle figure in lontananza"
episode23="La ragazza sul campo di battaglia"
episode24="All'interno della pancia"
#oav2="Persone semplici"

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
#create_directory "$output_specials_directory"

echo "Setting forced flag for subtitles..."
mkvpropedit --edit track:7 --set flag-forced=1 "$input_file1"

echo "Splitting input file based on chapters..."
mkvmerge -o "$output_pattern" --split chapters:6,11,17,22,28,33,38 "$input_file1"

#echo "Copying ova file..."
#cp "$input_file2" "${tmp_output_directory}ova2.mkv"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode17}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode18}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode19}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode20}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode21}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode22}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode23}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode24}"
#mkvpropedit "${tmp_output_directory}ova2.mkv" --edit info --set "title=${ova2}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e17.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e18.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e19.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e20.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e21.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e22.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e23.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e24.mkv"
#mv "${tmp_output_directory}ova2.mkv" "${output_specials_directory}Specials/s00e02.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/