#!/bin/bash
# Script: icon.sh
# Purpose: Generate a .desktop file with user-selected script and icon using Zenity.

# Prompt the user to select a script file
script_file=$(zenity --file-selection --title="Select a Script File" --file-filter="*.sh" --text="Choose a script to associate with the desktop icon.")
if [ -z "$script_file" ]; then
    zenity --error --text="No script selected. Exiting."
    exit 1
fi

# Prompt the user to select an icon image
icon_file=$(zenity --file-selection --title="Select an Icon Image" --file-filter="*.png *.jpg *.svg" --text="Choose an icon for the desktop shortcut.")
if [ -z "$icon_file" ]; then
    zenity --error --text="No icon selected. Exiting."
    exit 1
fi

# Prompt the user to enter a name for the desktop shortcut
shortcut_name=$(zenity --entry --title="Shortcut Name" --text="Enter a name for the desktop shortcut:")
if [ -z "$shortcut_name" ]; then
    zenity --error --text="No shortcut name provided. Exiting."
    exit 1
fi

# Generate the .desktop file content
desktop_file_path="$HOME/Desktop/$shortcut_name.desktop"
cat << EOF > "$desktop_file_path"
[Desktop Entry]
Type=Application
Name=$shortcut_name
Exec=$script_file
Icon=$icon_file
Terminal=true
EOF

# Make the .desktop file executable
chmod +x "$desktop_file_path"

# Notify the user of success
zenity --info --text="Desktop shortcut created successfully: $desktop_file_path"

