if [ -z "$DISK_THRESHOLD" ]; then
    read -p "Enter the threshold value for disk space monitoring (default is 10%): " threshold
    threshold=${threshold:-10}
    export DISK_THRESHOLD="$threshold"
fi

DEFAULT_PS1="$PS1"
WARNING_ADDED=false
PREVIOUS_USED_PERCENTAGE=0

check_disk_space() {
  user_home="$HOME"
  df_output=$(df -h "$user_home")
  used_percentage=$(echo "$df_output" | awk 'NR == 2 {print $5}' | sed 's/%//')
  
  if [ "$used_percentage" -ge "$DISK_THRESHOLD" ] && [ "$WARNING_ADDED" = false ]; then
    PS1="\[\e[31m\][Warning: $used_percentage% space used] \[\e[0m\]$DEFAULT_PS1"
    WARNING_ADDED=true
  elif [ "$used_percentage" -lt "$DISK_THRESHOLD" ] && [ "$WARNING_ADDED" = true ]; then
    PS1="$DEFAULT_PS1"
    WARNING_ADDED=false
  fi

  PREVIOUS_USED_PERCENTAGE="$used_percentage"
}

PROMPT_COMMAND="check_disk_space"
PS1="$DEFAULT_PS1"