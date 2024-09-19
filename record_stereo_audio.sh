#!/bin/bash

# Check if a directory name is passed as an argument
if [ -z "$1" ]; then
  echo "Error: No directory specified."
  exit 1
fi

# Create the directory if it doesn't already exist
if [ -d "$1" ]; then
  echo "Error: Directory '$1' already exists."
  exit 1
else
  cd
  mkdir "$1"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create directory '$1'."
    exit 1
  fi
fi

# Start the experiment on the remote machine and wait for it to fully finish
ssh pi@audio1.lmi.link "/home/pi/remotetesting/start_recording_stereo.sh"
if [ $? -ne 0 ]; then
  rm -r "$1"
  echo "Error: Failed to start or complete the experiment on the remote machine."
  exit 1
fi



# Download files with pattern *filt* from the remote machine into the specified directory
scp pi@audio1.lmi.link:/home/pi/experiment_audio_files/cache/audio_file_filtered.wav "$1"/.
if [ $? -ne 0 ]; then
  ssh pi@audio1.lmi.link "rm -r /home/pi/experiment_audio_files/cache"
  rm -r "$1"
  echo "Error: Failed to download files."
  exit 1
fi

# Remotely delete the cache directory on the remote machine
ssh pi@audio1.lmi.link "rm -r /home/pi/experiment_audio_files/cache"
if [ $? -ne 0 ]; then
  echo "Error: Failed to delete the cache directory on the remote machine."
  exit 1
fi

echo "File successfully downloaded to '$1' and remote cache directory deleted. Another student can start recording."

