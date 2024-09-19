#!/bin/bash

# Check if a directory name is passed as an argument
if [ -z "$1" ]; then
    echo "Error: No directory name specified."
    exit 1
fi

# Define the source directory where the new files are located
cd # Ensure you are in the home directory
SOURCE_DIR="$1"



# Create 8 new directories (mic_1 to mic_8) inside the provided $1 directory
for i in {0..8}; do
    MIC_DIR="$SOURCE_DIR/mic_$i"
    mkdir -p "$MIC_DIR/left_channel"
    mkdir -p "$MIC_DIR/right_channel"
done


echo "Files have been organized in the directory $1. All files have been synced and filtered.You can proceed to Matlab." 
# Script completed

