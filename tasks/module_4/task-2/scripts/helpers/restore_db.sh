# restore_db.sh

restore() {
  local _DB_FILE_PATH="$1"
  current_date=$(date +'%Y-%m-%d')
  backup_file="../data/$current_date-users.db.backup"
  if [ -f "$backup_file" ]; then
    cp "$backup_file" "$_DB_FILE_PATH"
    echo "Restored from $backup_file"
  else
    echo "No backup file found for restoration."
  fi
}