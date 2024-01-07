#!/bin/bash
#
# Script for Compiling and Running Kotlin Code Using Termux
# Author: IMTIAZ :)

# ANSI escape codes for colors
color_off=$(tput sgr0)
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

# Define bash colors
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'
BOLD='\e[1m'
UNDERLINE='\e[4m'
BLINK='\e[5m'
INVERSE='\e[7m'
RESET='\e[0m'  # Reset color to default

# Additional colors
LIGHT_RED='\e[1;31m'
LIGHT_GREEN='\e[1;32m'
LIGHT_YELLOW='\e[1;33m'
LIGHT_BLUE='\e[1;34m'
LIGHT_MAGENTA='\e[1;35m'
LIGHT_CYAN='\e[1;36m'
LIGHT_WHITE='\e[1;37m'

# Darker shades
DARK_GRAY='\e[1;30m'
DARK_RED='\e[1;31m'
DARK_GREEN='\e[1;32m'
DARK_YELLOW='\e[1;33m'
DARK_BLUE='\e[1;34m'
DARK_MAGENTA='\e[1;35m'
DARK_CYAN='\e[1;36m'
DARK_WHITE='\e[1;37m'

# Background colors
BG_BLACK='\e[40m'
BG_RED='\e[41m'
BG_GREEN='\e[42m'
BG_YELLOW='\e[43m'
BG_BLUE='\e[44m'
BG_MAGENTA='\e[45m'
BG_CYAN='\e[46m'
BG_WHITE='\e[47m'
BG_RESET='\e[49m'  # Reset background color

# Path to the file indicating whether the required packages are installed
FILE="/data/data/com.termux/files/home/KtMax/condition-2.0.txt"

# Clear the screen
    clear
    
# Text to print
text=$(cat <<'EOF'
$$$$$$\ $$\      $$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$$$$$$$\ 
\_$$  _|$$$\    $$$ |\__$$  __|\_$$  _|$$  __$$\ \____$$  |
  $$ |  $$$$\  $$$$ |   $$ |     $$ |  $$ /  $$ |    $$  / 
  $$ |  $$\$$\$$ $$ |   $$ |     $$ |  $$$$$$$$ |   $$  /  
  $$ |  $$ \$$$  $$ |   $$ |     $$ |  $$  __$$ |  $$  /   
  $$ |  $$|\$  /$$ |   $$ |     $$ |  $$ |  $$ | $$  /    
$$$$$$\ $$ | \_/ $$ |   $$ |   $$$$$$\ $$ |  $$ |$$$$$$$$\ 
\______|\__|     \__|   \__|   \______|\__|  \__|\________|
EOF
)

# Printing in different colors
echo -e "${cyan}${text}${color_off}"
echo -e "${magenta}====================================================================================================${color_off}"
echo -e "${green}                   	CEO - IMTIAZ Hacker    ${color_off}"
echo -e "${red}                 	TEAM - IMTIAZ Developer     ${color_off}"
echo -e "${green}                       	Devoloped By: IMTIAZ           ${color_off}"
echo -e "                        ${white}Version : 31.0${color_off}"
echo -e "${magenta}================================================================${color_off}"

# Ask the user for the operation
echo -e "${YELLOW}Select an operation:"
echo -e "1. Compile and Run Kotlin Code"
echo -e "2. Upgrade"
echo -e "3. Exit tool"
read OPERATION
    

case $OPERATION in
    1)
    # Check if required packages are already installed
if [ ! -f "$FILE" ] || [ "$(cat "$FILE")" -eq 0 ]; then
    # Request storage permission
    termux-setup-storage

    if [ $? -eq 0 ]; then
        echo -e "${LIGHT_GREEN}Storage Permission Successful"
        echo
    else
        echo -e "${LIGHT_RED}Storage Permission not allowed. Exiting."
        exit 1
        echo
    fi

    echo -e "${ORANGE}All Packages are now Installing. Starting..."
    echo

	pkg upgrade
	
	pkg update && upgrade -y
	
    # Update and upgrade Termux
    apt update && apt upgrade -y

    # Install OpenJDK 17 and Kotlin
    pkg install openjdk-17 -y
    pkg install kotlin -y

    # Mark that the packages are installed
    echo "1" > "$FILE"
    
    # Clear the screen
    clear

else
    echo -e "${LIGHT_CYAN}All Packages Are Already Installed"
    echo
fi
    
# Ask the user for the Kotlin file path
echo -e "${DARK_YELLOW}Enter Your Kotlin File Path Here : ${LIGHT_GREEN}"
read USER_INPUT

# Check if the user provided a file path
if [ -z "$USER_INPUT" ]; then
    echo -e "${BLUE} >>>>>> Invalid File Path. Exiting. <<<<<<${RED}"
    exit 1
   
fi

USER_CON="$USER_INPUT"
MAIN_PATH="${USER_CON%.*}"
echo
# Compile the Kotlin code
echo -e "${BLUE}Compiling....."
sleep 1
    echo
echo -e "Compiling........${GREEN}"
    echo
echo -e "Compiling...........${YELLOW}"
    echo
echo -e "Compiling...............${WHITE}"
    echo
echo -e "Compiling....................${CYAN}"
    echo
echo -e "Compiling.........................${CYAN}"
    echo
sleep 2
echo -e "Compiling...............................${LIGHT_RED}."
sleep 3
    echo

kotlinc "$MAIN_PATH.kt" -include-runtime -d "$MAIN_PATH.jar"

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo -e "${DARK_CYAN} >>>>>> Compiled Successfully!! <<<<<<${LIGHT_YELLOW}"
    echo
        echo
           
    # Run the compiled Jar file
    java -jar "$MAIN_PATH.jar"

    # Remove the created Jar file
    rm "$MAIN_PATH.jar"
    
        echo
            echo
else
    echo -e "${DARK_RED} >>>>>> Compilation Failed! Check for Errors. <<<<<<${LIGHT_CYAN}"
    
fi
;;
    2)
        # Upgrade Termux
        apt update && apt upgrade -y
        echo -e "${CYAN} >>>>>> Termux Upgraded Successfully!! <<<<<<${YELLOW}"
        ;;
    3)
        echo -e "${CYAN} >>>>>> Exiting the tool. <<<<<<${YELLOW}"
        exit 0
        ;;
    *)
        echo -e "${CYAN} >>>>>> Invalid Option! Exiting. <<<<<<${YELLOW}"
        ;;
esac
