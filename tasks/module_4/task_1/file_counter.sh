if [ -z "$1" ]
    then
        echo "Counting files recursively in a current directory..."
        COUNT="$(find . -type f | wc -l)"
    else
        echo "Counting files recursively in a $1 directory..."
        COUNT="$(find $1 -type f | wc -l)"
fi

echo "Files found: $COUNT"
