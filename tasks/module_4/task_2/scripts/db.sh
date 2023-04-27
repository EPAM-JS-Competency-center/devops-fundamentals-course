#!/bin/bash - 
#===============================================================================
#
#          FILE: db.sh
# 
#         USAGE: ./db.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/12/2023 23:13
#      REVISION:  ---
#===============================================================================

SCRIPT_DIR=`dirname "$(readlink -f "$BASH_SOURCE")"`
ROOT_DIR=${SCRIPT_DIR%/*}
USERS_DB=$ROOT_DIR/data/users.db
BACKUP_DIR=$ROOT_DIR/data/backups

checkCommand() {
  local command=$
  local optionalParam=$2

  if [[ ! -z "$optionalParam" && ("$command" != "list" || "$optionalParam" != "inverse") ]]
    then
      echo $commandErrorMessage
      exit 1
  fi
}

handleFileAbsence() {
  read -p "Database file does not exist. Would you like to create it? (y/n): " -n 1

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
  fi

  echo
  mkdir -p "$(dirname "$USERS_DB")" && touch "$USERS_DB"
}

runCommand() {
  local action="$1"
  local optional="$2"

  if [ ! -f $USERS_DB ]; then
    handleFileAbsence
  fi

  $action $optional
}

validateInput() {
  local input=$1

  if [[ ! "$input" =~ ^[a-zA-Z\ ]+$ ]]; then
    echo "Input must be latin letters!"
    exit 0
  fi
}

addEntry() {
  read -p "Enter user name: " userName
  validateInput $userName
  read -p "Enter user role: " userRole
  validateInput $userRole

  local userEntry="$userName, $userRole"

  echo $userEntry >> $USERS_DB
  echo "Entry '$userEntry' was added"
}

createBackup() {
  local backupFile=`date +"%m-%d-%Y"`-users.db.backup

  if [ ! -d $BACKUP_DIR ]; then
    mkdir -p $BACKUP_DIR
  fi

  cp $USERS_DB $BACKUP_DIR/$backupFile
  echo "Backup was created in 'data/backups/$backupFile'"
}

restoreFromBackup() {
  local backupFiles=$(find $BACKUP_DIR -type f -name "*.backup" 2> /dev/null)

  if [ ! -d "$BACKUP_DIR" ] || [ -z "$backupFiles" ]; then
    echo "No backup file found."
    exit 0
  fi

  local sortedBackups=$(echo "$backupFiles" | sed -e 's|^.*/\(.*\)$|\1\t\0|' | sort -r -n -t\- -k 3.1 -k 1.1 -k 2.1 | cut -f 2-)
  local latestBackup=$(echo "$sortedBackups" | head -1)

  cat $latestBackup > $USERS_DB
  echo "Database was restored from $latestBackup"
}

findUsersByName() {
  read -p "Enter target user name: " userName
  local users=`grep -i $userName $USERS_DB`

  if [ -z "$users" ]
    then
      echo "Users not found"
    else
      echo "$users"
  fi
}

listAllEntries() {
  local inverseParam=$1
  local fileContent=`awk '{ print NR". " $0 }' < $USERS_DB`

  if [ -z "$inverseParam" ]
    then
      echo "$fileContent"
    else
      echo "$fileContent" | tac
  fi
}

getHelpInfo() {
   echo "'$0' is intended for process operations with users database and supports next commands:"
   echo -e "\tadd -> add new entity to database;"
   echo -e "\thelp -> provide list of all available commands;"
   echo -e "\tbackup -> create a copy of current database;"
   echo -e "\trestore -> replaces database with its last created backup;"
   echo -e "\tfind -> found all entries in database by username;"
   echo -e "\tlist -> prints content of database and accepts optional 'inverse' param to print results in opposite order."
   exit 0
}

command=$1
optionalParam=$2

checkCommand $*

case "$command" in
  add) runCommand addEntry ;;
  backup) runCommand createBackup ;;
  restore) runCommand restoreFromBackup ;;
  find) runCommand findUsersByName ;;
  list) runCommand listAllEntries $optionalParam ;;
  help | '') getHelpInfo ;;
  *) echo "Invalid command: $*. Use '$0 help' for assistance." ;;
esac
