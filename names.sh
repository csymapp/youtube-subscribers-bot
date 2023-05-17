#!/bin/bash

# Input file with names
input_file="name.txt"

# Output file for combined names
output_file="names.txt"

# Counter variable
counter=0

# Read input file line by line
while IFS= read -r name
do
  ((counter++))

  # Check if the current line is even
  if ((counter % 2 == 0)); then
    # Combine current and previous lines with a space in between
    combined_name="$(sed -n "$((counter-1))p" "$input_file") $name"

    # Write combined name to output file
    echo "$combined_name" >> "$output_file"
  fi

done < "$input_file"
