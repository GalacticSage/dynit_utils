#!/bin/bash

input_file1="source_rips/FMA Brotherhood-D7/FMA Brotherhood-D7_t00.mkv"
#input_file2="source_rips/FMA Brotherhood-D7/FMA Brotherhood-D7_t02.mkv"

tmp_output_directory="tmp/disk7/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"
#output_specials_directory="${output_directory}Specials/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode49="Sentimenti di famiglia"
epsiode50="Agitazione a Central City"
episode51="L'esercito immortale"
episode52="La forza di tutti"
episode53="Le fiamme della vendetta"
episode54="Al di là del fuoco impetuoso"
episode55="Come si comporta un adulto"
episode56="Il ritorno del Comandante Supremo"
#oav4="Ancora un altro campo di battaglia"

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
mkvmerge -o "$output_pattern" --split chapters:7,12,17,22,27,33,38 "$input_file1"

#echo "Copying ova file..."
#cp "$input_file2" "${tmp_output_directory}ova4.mkv"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode49}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode50}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode51}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode52}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode53}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode54}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode55}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode56}"
#mkvpropedit "${tmp_output_directory}ova4.mkv" --edit info --set "title=${ova4}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e49.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e50.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e51.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e52.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e53.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e54.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e55.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e56.mkv"
#mv "${tmp_output_directory}ova4.mkv" "${output_specials_directory}Specials/s00e04.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/