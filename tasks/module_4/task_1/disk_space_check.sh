DEFAULT_THRESHOLD=15
RE='^[0-9]{1,2}$'

if [[ $1 =~ $RE && $(($1)) > 0 ]]
then
    THRESHOLD=$1
else
    THRESHOLD=$DEFAULT_THRESHOLD
    echo "Threshold was not specified or not an integer type in range 1-99."
fi

echo "Checking free disk space with a threshold of $THRESHOLD% on $(date)"

df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1 }' | while read data;
do
    used=$(echo $data | awk '{print $1}' | sed s/%//g)
    if [ $used -ge $THRESHOLD ]
    then
      partition=$(echo $data | awk '{print $2}')
      echo "WARNING: The partition \"$partition\" has used $used% of available space"
    fi
done
