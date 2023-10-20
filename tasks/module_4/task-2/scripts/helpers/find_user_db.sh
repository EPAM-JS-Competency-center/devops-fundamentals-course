#find_user_db.sh

function find {
  local DB_FILE_PATH="$1"
  if [ -n "$2" ]; then
    local USERNAME_TO_FIND="$2"
    if [ -f "$DB_FILE_PATH" ]; then
        found_entries=$(awk -v username="$USERNAME_TO_FIND" -F',' '$1 == username' "$DB_FILE_PATH")
        if [ -n "$found_entries" ]; then
            echo "$found_entries"
        else
            echo "User not found."
        fi
    else
        echo "Database file not found."
        exit 1
    fi
  else
    echo "Usage: db.sh find <username>"
    exit 1
  fi
}