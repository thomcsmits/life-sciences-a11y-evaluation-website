# zip all files for bulk download
cd assets/csv

# ------------------------------------------------------------ #

# zip all files
mkdir -p ./zips/all
zip -r ./zips/all/a11y-evaluations.zip . -i "*.csv"

# ------------------------------------------------------------ #

# zip files by date
for folder in *; do
    if [ "$folder" != "zips" ]; then
        mkdir -p ./zips/by_date
        zip -r ./zips/by_date/${folder}.zip "$folder"
    fi
done

# ------------------------------------------------------------ #

# zip files by file name
# first copy over files with new name
for folder in *; do
    if [ "$folder" != "zips" ]; then
        for file_path in $folder/*; do
            file_name=$(echo "$file_path" | sed 's|.*/||; s|\.csv$||')
            file_name_new="${folder}_${file_name}.csv"
            mkdir -p "./zips/by_name/${file_name}"
            cp "$file_path" ./zips/by_name/${file_name}/${file_name_new}
        done
    fi
done

# zip new folders
for folder in ./zips/by_name/*; do
    if [ -d "$folder" ]; then
    zip -r -j ${folder}.zip "$folder"
    rm -r $folder
    fi
done

# ------------------------------------------------------------ #