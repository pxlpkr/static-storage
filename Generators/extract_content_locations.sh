#!/bin/bash

# Get the base directory
BASE_DIR="$(cd $(dirname "$0")/.. 2>/dev/null && pwd)"

# Set the content and output directories
CONTENT_DIR=$BASE_DIR/Data-Storage
OUTPUT_DIR=$BASE_DIR/Reference

# Create the output directory if it does not exist
mkdir -p $OUTPUT_DIR

# transform_data() {
#   jq 'def map_category(type; name):
#         if type == "bossAltar" then "boss_altar"
#         elif type == "lootrunCamp" then "lootrun"
#         else type
#         end;

#       map({
#         name: .name,
#         coordinates: (.location // .coordinates)
#     })'
# }

# primary_data=$(cat $CONTENT_DIR/raw/content/content_book_dump.json | jq '[
# .cave[]
# ]' | transform_data)

# echo "$primary_data" > $OUTPUT_DIR/content_mapfeatures.json

MD5=$(md5sum $OUTPUT_DIR/content_mapfeatures.json | cut -d' ' -f1)

jq '. = [.[] | if (.id == "dataStaticContentMapFeatures") then (.md5 = "'$MD5'") else . end]' < $BASE_DIR/Data-Storage/urls.json > $BASE_DIR/Data-Storage/urls.json.tmp
mv $BASE_DIR/Data-Storage/urls.json.tmp $BASE_DIR/Data-Storage/urls.json

MD5=$(md5sum $CONTENT_DIR/content_locations.json | cut -d' ' -f1)

jq '. = [.[] | if (.id == "dataStaticContentLocations") then (.md5 = "'$MD5'") else . end]' < $BASE_DIR/Data-Storage/urls.json > $BASE_DIR/Data-Storage/urls.json.tmp
mv $BASE_DIR/Data-Storage/urls.json.tmp $BASE_DIR/Data-Storage/urls.json