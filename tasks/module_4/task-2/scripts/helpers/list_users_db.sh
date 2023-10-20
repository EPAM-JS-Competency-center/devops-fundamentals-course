#list_users_db.sh

function list () {
  local _DB_FILE_PATH="$1"
  local _INVERSE_FLAG="$2"
  if [ "$_INVERSE_FLAG" == "--inverse" ]; then
    awk -F',' '{data[NR] = $1 ", " $2} END {for (i = NR; i >= 1; --i) print i ". " data[i]}' "$_DB_FILE_PATH"
  else
    awk '{print NR ". " $1 ", " $2}' FS=',' "$_DB_FILE_PATH"
  fi
}