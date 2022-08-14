#!/bin/bash

SCRIPT_DIR=`dirname "$(readlink -f "$BASH_SOURCE")"`
ROOT_DIR=${SCRIPT_DIR%/*}
USERS_DB=$ROOT_DIR/data/users.db
BACKUP_DIR=$ROOT_DIR/data/backups

source $SCRIPT_DIR/db-commands
source $SCRIPT_DIR/db-helpers

commandErrorMessage="Invalid command: $*. Use '$0 help' for assistance."
command=$1
optionalParam=$2

checkCommand $*

case "$command" in
  add)
    runCommand addEntry
    ;;
  backup)
    runCommand createBackup
    ;;
  restore)
    runCommand restoreFromBackup
    ;;
  find)
    runCommand findByUsername
    ;;
  list)
    runCommand listAllEntries $optionalParam
    ;;
  '' | help)
    helpFunction
    ;;
  *)
    echo $commandErrorMessage
    ;;
esac
