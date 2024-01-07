#!/bin/bash
#
# Script for Compiling and Running Kotlin Code Using Termux
# Author: imam :)

# Define bash colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'

# Path to the file indicating whether the required packages are installed
FILE="/data/data/com.termux/files/home/KtMax/condition.txt"

# Function to download Kotlin packages
download_kotlin_packages() {
    # Check if required packages are already installed
    if [ ! -f "$FILE" ] || [ "$(cat "$FILE")" -eq 0 ]; then
        termux-setup-storage
        # Update and upgrade Termux
        apt update && apt upgrade -y

        # Install OpenJDK 17 and Kotlin
        pkg install openjdk-17 -y
        pkg install kotlin -y

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

    # Prompt for another operation
    prompt_for_operation
}

# Function to upgrade Termux
upgrade_termux() {
    # Upgrade Termux
    apt update && apt upgrade -y
    echo -e "${CYAN} >>>>>> Termux Upgraded Successfully!! <<<<<<${YELLOW}"

    # Prompt for another operation
    prompt_for_operation
}

# Function to prompt for another operation
prompt_for_operation() {
    # Ask the user if they want to perform another operation
    echo -e "${YELLOW}Do you want to perform another operation? (y/n): "
    read ANOTHER_OPERATION

    case $ANOTHER_OPERATION in
        y|Y) select_operation ;;
        n|N) echo -e "${CYAN} >>>>>> Exiting the tool. <<<<<<${YELLOW}" && exit 0 ;;
        *) echo -e "${CYAN} >>>>>> Invalid Option! Exiting. <<<<<<${YELLOW}" && exit 1 ;;
    esac
}

# Function to select an operation
select_operation() {
    # Ask the user for the operation
    echo -e "${YELLOW}Select an operation:"
    echo -e "1. Download Kotlin Packages and Compile Code"
    echo -e "2. Upgrade Termux"
    echo -e "3. Exit tool"
    read OPERATION

    # Execute the selected operation
    case $OPERATION in
        1) download_kotlin_packages ;;
        2) upgrade_termux ;;
        3) echo -e "${CYAN} >>>>>> Exiting the tool. <<<<<<${YELLOW}" && exit 0 ;;
        *) echo -e "${CYAN} >>>>>> Invalid Option! Exiting. <<<<<<${YELLOW}" && exit 1 ;;
    esac
}

# Start by prompting the user for the first operation
select_operation
