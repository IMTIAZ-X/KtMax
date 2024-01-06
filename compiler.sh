#!/bin/bash
#
# Script for Compiling and Running Kotlin Code Using Termux
# Author: imam :)

# Define bash colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'

# Path to the file indicating whether the required packages are installed
FILE="/data/data/com.termux/files/home/KtMax/condition.txt"

# Check if required packages are already installed
if [ ! -f "$FILE" ] || [ "$(cat "$FILE")" -eq 0 ]; then
    # Update and upgrade Termux
    apt update && apt upgrade

    # Install OpenJDK 17 and Kotlin
    pkg install openjdk-17
    pkg install kotlin

    # Mark that the packages are installed
    echo "1" > "$FILE"
else
    echo "All Packages Are Already Installed"
fi

# Ask the user for the Kotlin file path
echo -e "${YELLOW}Enter Your Kotlin File Path Here : "
read USER_INPUT
USER_CON="$USER_INPUT"
MAIN_PATH="${USER_CON%.*}"

# Compile the Kotlin code
echo "Compiling..............."
kotlinc "$MAIN_PATH.kt" -include-runtime -d "$MAIN_PATH.jar"

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo -e "${CYAN} >>>>>> Compiled Successfully!! <<<<<<${YELLOW}"
    
    # Run the compiled Jar file
    java -jar "$MAIN_PATH.jar"

    # Remove the created Jar file
    rm "$MAIN_PATH.jar"
else
    echo -e "${CYAN} >>>>>> Compilation Failed! Check for Errors. <<<<<<${YELLOW}"
fi
