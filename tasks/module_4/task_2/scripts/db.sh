#!/bin/bash

DB_FILE="users.db"
FULL_PATH="../data/$DB_FILE"

isInverstedLine="$2"

if [ ! -e "$FULL_PATH" ]; then
    read -p "The 'users.db' file does not exist. Do you want to create it? (Y/N): " answer
    if [ "$answer" = "Y" ] || [ "$answer" = "y" ]; then
        touch "$FULL_PATH"
        echo "The 'users.db' file has been created."
    else
        echo "The file not created. Try again"
        exit 1
    fi
fi

function validateInput {
    local input="$1"
    local name="$2"
    if [[ "$input" =~ ^[a-zA-Z]+$ ]]; then
        return 0  # Validation passed
    else
        echo "Invalid $name. Must contain Latin letters only."
        return 1  # Validation failed
    fi
}

function addUser {
    while true; do
        echo "Enter user name (latin letters only):"
        read username
        if validateInput "$username" "username"; then
            break
        fi
    done

    while true; do
        echo "Enter a role (latin letters only):"
        read role
        if validateInput "$role" "role"; then
            break
        fi
    done

    echo "$username, $role" >> "$FULL_PATH"
    echo "User: '$username' with role: '$role' added to DB"
}

function backupDB {
    timestamp=$(date +"%Y%m%d%H%M%S")
    pathBackupFilename="../data/$timestamp-users.db.backup"
    cp "$FULL_PATH" "$pathBackupFilename"
    echo "Backup created: $pathBackupFilename"
}

function restoreBackup {
    latestBackup=$(ls ../data/*-users.db.backup | tail -n 1)

    if [ -n "$latestBackup" ]; then
        cp "$latestBackup" "$FULL_PATH"
        echo "Backup '$latestBackup' restored as 'users.db'."
    else
        echo "No backup file found."
    fi
}

function findUser {
    echo "Enter a username to find:"
    read searchUsername
    found=0
    while read -r line; do
        username=$(echo "$line" | cut -d ',' -f 1)
        role=$(echo "$line" | cut -d ',' -f 2)
        if [[ "$username" = "$searchUsername" ]]; then
            echo "User: $username, Role: $role"
            found=1
        fi
    done < "$FULL_PATH"

    if [ "$found" -eq 0 ]; then
        echo "User not found."
    fi
}

function listUsers() {
    lineIndex=1
    while IFS= read -r line; do
        username=$(echo "$line" | cut -d ',' -f 1)
        role=$(echo "$line" | cut -d ',' -f 2)
        lines[$lineIndex]="$username, $role"
        ((lineIndex++))
    done < "$FULL_PATH"

    for ((i = 1; i < lineIndex; i++)); do
        index="$i"
        if [ "$isInverstedLine" = "--inverse" ]; then
            index=$((lineIndex - i))
        fi
        echo "$index. ${lines[$index]}"
    done
}

function help {
    echo
    echo "List of commands:"
    echo
    echo "help       Prints instructions on how to use this
                     script with a description of all available
                     commands."
    echo
    echo "add        Adds a new line to the users.db. The script 
                     must prompt a user to type the username of 
                     a new entity. After entering the username, 
                     the user must be prompted to type a role."
    echo "backup     Creates a new file, named %date%-users.db.backup
                     which is a copy of current users.db."
    echo "restore    Takes the last created backup file and
                     replaces users.db with it. If there are 
                     no backups - script should print: 
                     “No backup file found”"
    echo "find       Prompts the user to type a username, then 
                     prints username and role if such exists in 
                     users.db. If there is no user with the 
                     selected username, the script must print: 
                     “User not found”. If there is more than one 
                     user with such a username, print all found 
                     entries."
    echo "list       Prints the content of the users.db in the format: 
                     N. username, role

                     '--inverse' which allows results in the opposite order"
    echo
    echo "Syntax: db.sh [command]"
    echo
}

# Main menu for the script
case "$1" in
    "add") addUser ;;
    "backup") backupDB ;;
    "restore") restoreBackup ;;
    "find") findUser ;;
    "list") listUsers ;;
    "help" | '' | *)  help ;;
esac