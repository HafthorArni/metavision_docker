#!/bin/bash

# Base directory containing the recordings
BASE_DIRECTORY=$1

if [ -z "$BASE_DIRECTORY" ]; then
  echo "Please provide the base directory containing the recordings."
  exit 1
fi

# Find all .raw files in subdirectories of the base directory and convert them to .avi
find "$BASE_DIRECTORY" -type f -name "*.raw" | while read -r raw_file; do
  # Define the output .avi file name by replacing .raw with .avi
  output_file="${raw_file%.raw}.avi"
  echo "Converting $raw_file to $output_file"
  metavision_file_to_video -i "$raw_file" -o "$output_file"
done
