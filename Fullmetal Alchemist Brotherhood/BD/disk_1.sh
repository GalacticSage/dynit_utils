#!/bin/bash

input_file1="source_rips/FMA Brotherhood-D1/FMA Brotherhood-D1_t00.mkv"
#input_file2="source_rips/FMA Brotherhood-D1/FMA Brotherhood-D1_t02.mkv"

tmp_output_directory="tmp/disk1/"
output_directory="output/Fullmetal_Alchemist_Brotherhood/"
output_season_directory="${output_directory}s01/"
output_specials_directory="${output_directory}Specials/"

output_pattern="${tmp_output_directory}segment_%d.mkv"

episode1="L'alchimista d'acciaio"
episode2="Il giorno dell'inizio"
episode3="La città dell'eresia"
episode4="Il tormento dell'alchimista"
episode5="Pioggia di dolore"
episode6="La strada della speranza"
episode7="La verità nascosta"
episode8="Il laboratorio 5"
#ova1="L'Alchimista cieco"

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
#mkvpropedit --edit track:4 --set flag-forced=1 "$input_file2"

echo "Splitting input file based on chapters..."
mkvmerge -o "$output_pattern" --split chapters:7,13,19,25,31,38,44 "$input_file1"

#echo "Copying ova file..."
#cp "$input_file2" "${tmp_output_directory}ova1.mkv"

echo "Setting titles for segments..."
mkvpropedit "${tmp_output_directory}segment_1.mkv" --edit info --set "title=${episode1}"
mkvpropedit "${tmp_output_directory}segment_2.mkv" --edit info --set "title=${episode2}"
mkvpropedit "${tmp_output_directory}segment_3.mkv" --edit info --set "title=${episode3}"
mkvpropedit "${tmp_output_directory}segment_4.mkv" --edit info --set "title=${episode4}"
mkvpropedit "${tmp_output_directory}segment_5.mkv" --edit info --set "title=${episode5}"
mkvpropedit "${tmp_output_directory}segment_6.mkv" --edit info --set "title=${episode6}"
mkvpropedit "${tmp_output_directory}segment_7.mkv" --edit info --set "title=${episode7}"
mkvpropedit "${tmp_output_directory}segment_8.mkv" --edit info --set "title=${episode8}"
#mkvpropedit "${tmp_output_directory}ova1.mkv" --edit info --set "title=${ova1}"

echo "Moving and renaming files..."
mv "${tmp_output_directory}segment_1.mkv" "${output_season_directory}s01e01.mkv"
mv "${tmp_output_directory}segment_2.mkv" "${output_season_directory}s01e02.mkv"
mv "${tmp_output_directory}segment_3.mkv" "${output_season_directory}s01e03.mkv"
mv "${tmp_output_directory}segment_4.mkv" "${output_season_directory}s01e04.mkv"
mv "${tmp_output_directory}segment_5.mkv" "${output_season_directory}s01e05.mkv"
mv "${tmp_output_directory}segment_6.mkv" "${output_season_directory}s01e06.mkv"
mv "${tmp_output_directory}segment_7.mkv" "${output_season_directory}s01e07.mkv"
mv "${tmp_output_directory}segment_8.mkv" "${output_season_directory}s01e08.mkv"
#mv "${tmp_output_directory}ova1.mkv" "${output_specials_directory}Specials/s00e01.mkv"

echo "Cleaning up temporary files..."
rm -rf tmp/
