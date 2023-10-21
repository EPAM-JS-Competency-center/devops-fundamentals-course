#!/bin/bash
#===============================================================================
#
#          FILE:  db.sh
# 
#         USAGE:  interacts with users.db 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Mostafa Zaki (), mosafazke@gmail.com
#       COMPANY:  _
#       VERSION:  1.0
#       CREATED:  21/10/23 13:46:06 CEST
#      REVISION:  ---
#===============================================================================

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DB_DIR="$DIR/../data"
DB_FILE="users.db"
BACKUP_DIR="$DIR/../backup"


validate_input() {
  local input="$1"
  if [[ ! "$input" =~ ^[a-zA-Z]+$ ]]; then
    echo "Invalid input. Please use Latin letters only."
    return 1
  fi
}

show_help() {
  echo "Usage: $0 [command]"
  echo "Available commands:"
  echo "  add              Add a new user to $DB_FILE"
  echo "  backup           Create a backup of $DB_FILE"
  echo "  restore          Restore $DB_FILE from the latest backup"
  echo "  find             Find and display user(s) by username"
  echo "  list             List all users in $DB_FILE"
  echo "  help             Display this help message"
}

# Initialize the db file if it doesn't exist
if [ ! -f "$DB_DIR/$DB_FILE" ]; then
  echo "users.db not found. Do you want to create one? (yes/no)"
  read answer
  if [ "$answer" = "yes" ]; then
    touch "$DB_FILE"
    echo "users.db created."
  else
    echo "Exiting."
    exit 1
  fi
fi



case "$1" in
  add)
    echo "Enter a new username:"
    read username
    validate_input "$username" || exit 1

    echo "Enter a role for $username:"
    read role
    validate_input "$role" || exit 1

    echo "$username, $role" >> "$DB_DIR/$DB_FILE"
    echo "User $username added to $DB_FILE."
    ;;
  backup)
    mkdir -p "$BACKUP_DIR"
    cp "$DB_DIR/$DB_FILE" "$BACKUP_DIR/$(date +'%Y-%m-%d')-users.db.backup"
    echo "Backup created in $BACKUP_DIR."
    ;;
  restore)
    latest_backup=$(ls -t "$BACKUP_DIR" | head -n 1)
    if [ -z "$latest_backup" ]; then
      echo "No backup file found."
    else
      cp "$BACKUP_DIR/$latest_backup" "$DB_DIR/$DB_FILE"
      echo "Restored $DB_FILE from $latest_backup."
    fi
    ;;
  find)
    echo "Enter a username to find:"
    read search_username
    found=0
    while IFS=',' read -r username role; do
      if [ "$username" = "$search_username" ]; then
        echo "Username: $username, Role: $role"
        found=1
      fi
    done < "$DB_DIR/$DB_FILE"
    if [ $found -eq 0 ]; then
      echo "User not found."
    fi
    ;;
  list)
    inverse=0
    if [ "$2" = "--inverse" ]; then
      inverse=1
    fi
    line_number=1
    lines=()
    while IFS=',' read -r username role; do
      lines=("${lines[@]}" "  $line_number. $username, $role")
      ((line_number++))
    done < "$DB_DIR/$DB_FILE"
    
    if [ $inverse -eq 0 ]; then
      for ((i = 0; i < ${#lines[@]}; i++)); do
        echo "${lines[$i]}"
      done
    else
      for ((i = ${#lines[@]} - 1; i >= 0; i--)); do
        echo "${lines[$i]}"
      done
    fi
    ;;
  help)
    show_help
    ;;
  *)
    show_help
    exit 1
    ;;
esac




























