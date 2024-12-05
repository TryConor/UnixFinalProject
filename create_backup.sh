#!/bin/bash

# Use Zenity to select a source directory
SOURCE_DIR=$(zenity --file-selection --directory --title="Select Source Directory")
# Exit if no source directory is selected or user cancels dialogue
if [ -z "$SOURCE_DIR"]; then
  zenity --error --text="No source directory selected. Exiting script."
  exit 1
fi


# Use Zenity to select the destination folder
DEST_DIR=$(zenity --file-selection --directory --title="Select Destination Directory")
# Exit if no destination folder is selected or user cancels dialogue
if [ -z "$DEST_DIR" ]; then
    zenity --error --text="No destination directory selected. Exiting."
    exit 1
fi


# Create a tarball of the source folder and backup
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
BACKUP_PATH="$DEST_DIR/$BACKUP_NAME"

tar -czf "$BACKUP_PATH" -C "$SOURCE_DIR" .

# If using Zenity display the success or failure of the backup
if [ $? -eq 0 ]; then
    zenity --info --text="Backup successful! Backup file created at:\n$BACKUP_PATH"
else
    zenity --error --text="Backup failed. Please check the source and destination directories."
    exit 1
fi
