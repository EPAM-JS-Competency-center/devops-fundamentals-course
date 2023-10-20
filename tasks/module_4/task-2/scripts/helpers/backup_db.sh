# backup_db.sh

backup() {
  local DB_FILE_PATH="$1"
  local current_date=$(date +'%Y-%m-%d')
  local backup_file="../data/$current_date-users.db.backup"
  cp "$DB_FILE_PATH" "$backup_file"
  echo "Backup created as $backup_file"
}