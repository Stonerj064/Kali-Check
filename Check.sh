#!/bin/bash

# Set ANSI colour codes
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# Expected users and their roles
declare -A expected_users=(
    [skywalkerl]="General Administrator"
    [organal]="General Administrator"
    [yoday]="General Administrator"
    [soloh]="Web Server Administrator"
    [kenobio]="Web Server Administrator, Database Administrator"
    [calrissianl]="FTP Server Administrator"
    [amidapal]="FTP Server Administrator"
    [jinnaq]="Database Administrator"
    [tanoa]="Authorized User"
    [fettb]="Authorized User"
    [antillesw]="Authorized User"
    [rendar]="Authorized User"
    [shanb]="Authorized User"
    [syndullah]="Authorized User"
)

echo "Checking expected users..."
for user in "${!expected_users[@]}"; do
    if id "$user" &>/dev/null; then
        echo -e "${GREEN}[Yes]${RESET} $user - ${expected_users[$user]}"
    else
        echo -e "${RED}[No]${RESET} $user - ${expected_users[$user]}"
    fi

done

echo

# Check for unexpected users
echo "Checking for unexpected users..."
for sys_user in $(cut -d: -f1 /etc/passwd); do
    found=no
    for expected in "${!expected_users[@]}"; do
        if [[ "$sys_user" == "$expected" ]]; then
            found=yes
            break
        fi
    done
    if [[ "$found" == "no" ]]; then
        echo -e "${YELLOW}[Unexpected]${RESET} $sys_user"
    fi
done

echo

# Check for software compliance
echo "Checking Software Compliance..."

# Check for Firefox
if [ -f "/usr/bin/firefox" ]; then
    echo -e "${GREEN}[Yes]${RESET} Firefox Installed"
else
    echo -e "${RED}[No]${RESET} Firefox Installed"
fi

# Check for Microsoft Edge
if [ -f "/usr/bin/microsoft-edge" ]; then
    echo -e "${GREEN}[Yes]${RESET} Microsoft Edge Installed"
else
    echo -e "${RED}[No]${RESET} Microsoft Edge Installed"
fi

# Check for LibreOffice
if [ -f "/usr/bin/soffice" ]; then
    echo -e "${GREEN}[Yes]${RESET} LibreOffice Installed"
else
    echo -e "${RED}[No]${RESET} LibreOffice Installed"
fi

echo
read -p "Press Enter to finish..."
