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
}

# Function to upgrade Termux
upgrade_termux() {
    # Upgrade Termux
    apt update && apt upgrade -y
    echo -e "${CYAN} >>>>>> Termux Upgraded Successfully!! <<<<<<${YELLOW}"
}

# Function to exit the tool
exit_tool() {
    echo -e "${CYAN} >>>>>> Exiting the tool. <<<<<<${YELLOW}"
    exit 0
}

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
    3) exit_tool ;;
    *) echo -e "${CYAN} >>>>>> Invalid Option! Exiting. <<<<<<${YELLOW}" ;;
esac
    

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
