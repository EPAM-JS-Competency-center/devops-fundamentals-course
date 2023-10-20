#!/bin/bash

source "./helpers/help_db.sh"
source "./helpers/add_user_db.sh"
source "./helpers/backup_db.sh"
source "./helpers/restore_db.sh"
source "./helpers/list_users_db.sh"
source "./helpers/find_user_db.sh"

DB_FILE_PATH="../data/users.db"
USERNAME_OR_INVERSE_FLAG=$2;

case $1 in
  add)            add "$DB_FILE_PATH" ;;
  backup)         backup "$DB_FILE_PATH" ;;
  restore)        restore "$DB_FILE_PATH" ;;
  find)           find "$DB_FILE_PATH" "$USERNAME_OR_INVERSE_FLAG" ;;
  list)           list "$DB_FILE_PATH" "$USERNAME_OR_INVERSE_FLAG" ;;
  help | '' | *)  help ;;
esac