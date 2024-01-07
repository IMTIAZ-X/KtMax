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
    
    # Function to download Kotlin packages
kotlin() {
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
clear

    #logo 
    logo

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
   # Prompt for another operation
    prompt_for_operation
fi

USER_CON="$USER_INPUT"
MAIN_PATH="${USER_CON%.*}"
echo
# Compile the Kotlin code
echo -e "${BLUE}Compiling....."
sleep 1
    echo
echo -e "Compiling........${GREEN}"
sleep 1
    echo
echo -e "Compiling...........${YELLOW}"
sleep 2
    echo
echo -e "Compiling...............${WHITE}"
    echo
echo -e "Compiling....................${CYAN}"
    echo
echo -e "Compiling.........................${CYAN}"
sleep 1
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
    

}

php() {

# Path to the file indicating whether the required packages are installed
FILE="/data/data/com.termux/files/home/KtMax/condition.txt"

# Check if required packages are already installed
if [ ! -f "$FILE" ] || [ "$(cat "$FILE")" -eq 0 ]; then
    # Request storage permission
    termux-setup-storage

    if [ $? -eq 0 ]; then
        echo "${LIGHT_GREEN}Storage Permission Successful"
    else
        echo "${LIGHT_RED}Storage Permission not allowed. Exiting."
        exit 1
    fi

    echo "${WHITE}All Packages are now Installing. Starting..."

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
    echo
fi

# Ask the user for the PHP file path
echo -e "${WHITE}Enter Your PHP File Path Here : "
read USER_INPUT

# Check if the user provided a file path
if [ -z "$USER_INPUT" ]; then
    echo -e "${LIGHT_RED} >>>>>> Invalid File Path. Exiting. <<<<<<${WHITE}"
    exit 1
fi

USER_CON="$USER_INPUT"
MAIN_PATH="${USER_CON%.*}"
echo

# Run the PHP code
echo -e "${LIGHT_CYAN}Running PHP Code.....${WHITE}"
php "$MAIN_PATH.php"

    #logo 
    logo
}


# Function to upgrade Termux
upgrade_termux() {
    # Upgrade Termux
    apt update && apt upgrade -y
    clear
    echo -e "${CYAN} >>>>>> Termux Upgraded Successfully!! <<<<<<${YELLOW}"
    echo
    echo -e "${LIGHT_RED}Do you want to agian use this tool? (y/n): "
    read ANOTHER_OPERATION
 clear
 
    #logo 
    logo
}

# Function to exit the tool
exit_tool() {

#logo code

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

#logo code

	echo -e "${LIGHT_RED}Do you want to exit this tool? (y/n): "
    read ANOTHER_OPERATION
    echo -e "${CYAN} >>>>>> Exiting the tool. <<<<<<${YELLOW}"
    #logo 
    logo
    exit 0
}

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
echo -e "${LIGHT_RED}${text}${color_off}"
echo -e "${magenta}====================================================================================================${color_off}"
echo -e "${green}                   	CEO - IMTIAZ Hacker    ${color_off}"
echo -e "${red}                 	TEAM - IMTIAZ Developer     ${color_off}"
echo -e "${green}                       	Devoloped By: IMTIAZ           ${color_off}"
echo -e "                        ${white}Version : 31.0${color_off}"
echo -e "${magenta}================================================================${color_off}"

# Function to prompt for another operation
prompt_for_operation() {
    # Ask the user if they want to perform another operation
    echo -e "${LIGHT_RED}Do you want to use this tool? (y/n): "
    read ANOTHER_OPERATION

    case $ANOTHER_OPERATION in
        y|Y) select_operation ;;
        n|N) echo -e "${CYAN} >>>>>> Exiting the tool. <<<<<<${YELLOW}" && exit 0 ;;
        *) echo -e "${CYAN} >>>>>> Invalid Option! Exiting. <<<<<<${YELLOW}" && exit 1 ;;
    esac
}

#logo code
logo() {
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
echo -e "${LIGHT_GREEN}${text}${color_off}"
echo -e "${magenta}====================================================================================================${color_off}"
echo -e "${green}                   	CEO - IMTIAZ Hacker    ${color_off}"
echo -e "${red}                 	TEAM - IMTIAZ Developer     ${color_off}"
echo -e "${green}                       	Devoloped By: IMTIAZ           ${color_off}"
echo -e "                        ${white}Version : 31.0${color_off}"
echo -e "${magenta}================================================================${color_off}"
}


# Loop for continuous operations until the user chooses to exit
while true; do
# Function to select an operation
select_operation() {
# Ask the user for the operation
echo -e "${YELLOW}Select an operation:"
echo -e "1. Kotlin Compiler"
echo -e "2. Compile and Run PHP Code"
echo -e "3. Upgrade Termux"
echo -e "4. Exit tool"
echo -e "${LIGHT_RED}Select an operation:${LIGHT_YELLOW}"
read OPERATION

# Execute the selected operation
case $OPERATION in
    1) kotlin ;;
    2) php ;;
    3) upgrade_termux ;;
    4) exit_tool ;;
    *) echo -e "${CYAN} >>>>>> Invalid Option! Exiting. <<<<<<${YELLOW}" ;;
    esac
    
 
 }
 
 # Start by prompting the user for the first operation
select_operation

done
