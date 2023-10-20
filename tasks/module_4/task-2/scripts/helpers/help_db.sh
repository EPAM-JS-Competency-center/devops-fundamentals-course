function help {
  echo "Manages users in db. It accepts a single parameter with a command name."
  echo
  echo "Syntax: db.sh [command]"
  echo
  echo "List of available commands:"
  echo
  echo "add           Adds a new line to the users.db. Script must prompt user to type a
              username of new entity. After entering username, user must be prompted to
              type a role."
  echo "backup        Creates a new file, named" $filePath".backup which is a copy of
              current" $fileName
  echo "restore       Restores the database from a previously created backup. If a backup file
              with the current date exists, it will be used to overwrite the current
              database. If no backup file is found, the script will inform you that no
              backup file is available for restoration."
  echo "find          Prompts user to type a username, then prints username and role if such
              exists in users.db. If there is no user with selected username, script must print:
              “User not found”. If there is more than one user with such username, print all
              found entries."
  echo "list          Prints the contents of users.db in the format: N. username, role
              where N is the line number of an actual record. By default, it lists the records
              in ascending order. You can use the additional optional parameter --inverse to
              reverse the order and list the records from bottom to top. For example, running
              the command "\$ db.sh list --inverse" will return the result as follows:

              \`$ db.sh list --inverse\`

              10. John, admin
              9. Valerie, user
              8. Ghost, guest"
}