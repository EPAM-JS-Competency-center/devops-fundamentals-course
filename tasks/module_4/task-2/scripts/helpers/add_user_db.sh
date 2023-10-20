# add_user_db.sh

add() {
  local _DB_FILE_PATH="$1"
  while true; do
    read -p "Type the username (latin letters only) of a new entity: " _username
    if [[ "$_username" =~ ^[a-zA-Z]+$ ]]; then
        break
    else
        echo "Incorrect input, latin letters only"
        exit 1
    fi
  done
  while true; do
    read -p "Type a role (latin letters only): " _role
    if [[ "$_role" =~ ^[a-zA-Z]+$ ]]; then
        break
    else
        echo "Incorrect iput, litin letters only"
        exit 1
    fi
  done
  echo "$_username,$_role" >> "$_DB_FILE_PATH"
  echo "Data saved to $_DB_FILE_PATH"
}