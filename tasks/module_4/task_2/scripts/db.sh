#!/bin/bash

# Define database file
DB_FILE="../data/users.db"

# Check the existence of the DB_FILE and create it if it does not exist
function check_file {
  if [ ! -f $DB_FILE ]; then
    read -p "$DB_FILE does not exist. Do you want to create it? [Y/n]: " create
    if [ "$create" == "Y" ] || [ "$create" == "y" ]; then
      touch $DB_FILE
      echo "$DB_FILE has been created."
    else
      echo "Operation canceled."
      exit 0
    fi
  fi
}

# Function to add a user
function add_user {
  check_file
  read -p "Enter username: " username
  read -p "Enter role: " role

  if [[ $username =~ ^[A-Za-z]+$ ]] && [[ $role =~ ^[A-Za-z]+$ ]]; then
    echo "$username, $role" >> $DB_FILE
    echo "User added successfully!"
  else
    echo "Invalid username or role."
  fi
}

# Function to print help instructions
function print_help {
  echo "list of commands:"
  echo "add - Adds a new user to the database"
  echo "backup - Creates a backup of the current database"
  echo "restore - Restores the last backup"
  echo "find - Finds a user in the database"
  echo "list - Lists all users in the database"
  echo "help - Prints this help message"
}

# Function to create a backup
function backup_db {
  check_file
  cp $DB_FILE "../data/$(date +%Y%m%d)-users.db.backup"
  echo "Backup created successfully!"
}

# Function to restore the latest backup
function restore_db {
  latest_backup=$(ls ../data/*-users.db.backup | sort -r | head -n 1)
  
  if [ "$latest_backup" != "" ]; then
    cp $latest_backup $DB_FILE
    echo "Database restored from the latest backup!"
  else
    echo "No backup file found."
  fi
}

# Function to find a user
function find_user {
  check_file
  read -p "Enter username: " username

  result=$(grep -i "^$username," $DB_FILE)
  
  if [ "$result" != "" ]; then
    echo "Found user(s): $result"
  else
    echo "User not found."
  fi
}

# Function to list all users
function list_users {
  check_file
  if [ "$1" == "--inverse" ]; then
    awk '{
		a[i++]=$0
	} END {
	    for (j=i-1; j>=0;) print a[j--] 
	}' $DB_FILE | nl
  else
    cat -n $DB_FILE
  fi
}

# Parse the command
case $1 in
  "add") add_user ;;
  "help") print_help ;;
  "backup") backup_db ;;
  "restore") restore_db ;;
  "find") find_user ;;
  "list") list_users $2 ;;
  *) print_help ;;
esac
