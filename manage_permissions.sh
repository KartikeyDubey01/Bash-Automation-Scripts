#!/bin/bash


# Function to display usage information

display_usage() {

    echo "Usage: $0 <file> <permissions>"

    echo "Example: $0 myfile.txt 755"

    echo "Permissions Format: Numeric (e.g., 755) or Symbolic (e.g., u+rwx,g+rw,o-rwx)"

}


# Check if the correct number of arguments are provided

if [ $# -ne 2 ]; then

    echo "Error: Incorrect number of arguments."

    display_usage

    exit 1

fi


# Assign arguments to variables

file=$1

permissions=$2


# Check if the file exists

if [ ! -e "$file" ]; then

    echo "Error: File '$file' does not exist."

    exit 1

fi


# Apply the new permissions

chmod "$permissions" "$file"

if [ $? -ne 0 ]; then

    echo "Error: Failed to apply permissions. Ensure you have provided valid inputs."

    exit 1

fi


# Display the updated permissions

echo "Permissions updated successfully."

echo "Updated permissions for '$file':"

ls -l "$file"
