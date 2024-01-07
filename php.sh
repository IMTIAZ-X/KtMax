#!/bin/bash
#
# Script for Compiling and Running PHP Code Using Termux
# Author: imam :)

# Define bash colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
LIGHT_GREEN='\033[1;32m'
LIGHT_RED='\033[1;31m'
LIGHT_CYAN='\033[1;36m'
LIGHT_MAGENTA='\033[1;35m'

# Path to the file indicating whether the required packages are installed
FILE="/data/data/com.termux/files/home/KtMax/php_condition.txt"

# Function to download PHP packages
download_php_packages() {

    # Check if required packages are already installed
    if [ ! -f "$FILE" ] || [ "$(cat "$FILE")" -eq 0 ]; then
        # Request storage permission
        termux-setup-storage

        if [ $? -eq 0 ]; then
            echo -e "${LIGHT_GREEN}Storage Permission Successful"
        else
            echo -e "${LIGHT_RED}Storage Permission not allowed. Exiting."
            exit 1
        fi

        echo -e "${LIGHT_MAGENTA}All Packages are now Installing. Starting..."

        # Upgrade Termux
        pkg upgrade -y

        # Update and upgrade Termux
        apt update && apt upgrade -y

        # Install PHP
        pkg install php -y

        # Mark that the packages are installed
        echo "1" > "$FILE"

        # Clear the screen
        clear

    else
        echo -e "${LIGHT_CYAN}All Packages Are Already Installed"
    fi

    # Ask the user for the PHP file path
    echo -e "${WHITE}Enter Your PHP File Path Here : "
    read USER_INPUT

    # Check if the user provided a file path
    if [ -z "$USER_INPUT" ]; then
        echo -e "${LIGHT_RED}Invalid File Path. Exiting.${WHITE}"
        exit 1
    fi

    USER_CON="$USER_INPUT"
    MAIN_PATH="${USER_CON%.*}"

    # Compile the PHP code
    echo
    echo -e "${LIGHT_MAGENTA}Running PHP Code.....${WHITE}"
    echo
	# Compile the Kotlin code
	echo -e "${BLUE}Compiling....."
	sleep 1
    echo
	echo -e "Compiling........${GREEN}"
    echo
	echo -e "Compiling...........${YELLOW}"
    echo
	echo -e "Compiling...............${LIGHT_CYAN}"
    echo
	echo -e "Compiling....................${CYAN}"
    echo
	echo -e "Compiling.........................${CYAN}"
    echo
	sleep 1
	echo -e "Compiling...............................${LIGHT_RED}."
	sleep 2
    echo 
    echo -e "${YELLOW}"
    php "$MAIN_PATH.php"
    echo
}

Back(){
source compiler-2.0.sh
}

# Function to select an operation
select_operation() {
    # Ask the user for the operation
    echo -e "${YELLOW}Select an operation:"
    echo -e "1. PHP Run Script"
    echo -e "2. Back Tool"
    read OPERATION

    # Execute the selected operation
    case $OPERATION in
        1) download_php_packages ;;
        2) Back ;;
        *) echo -e "${CYAN}Invalid Option! Exiting.${YELLOW}" && exit 1 ;;
    esac
}

# Start by prompting the user for the first operation
select_operation
