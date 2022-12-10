#!/bin/sh
USERNAME=$1
PASSWORD=$2
HOST=$3
LOCAL_HOSTNAME=$4
LOCAL_USERNAME=$5
LOCAL_PORT=$6
LOCAL_PASSWORD=$7
DIRECTORY=$8
RANDOM_CODE=$RANDOM
DATE=$(date +%Y-%m-%d)
FILE_NAME="$DATE-$RANDOM_CODE"
QUERY="SELECT datname FROM pg_database WHERE datname LIKE 'subsbase-%';"
export PGPASSWORD="$PASSWORD"
DIR_PATH=$DIRECTORY
if [ ! -d $DIR_PATH ]; then
    mkdir -p $DIR_PATH
fi
echo HOST $HOST
for line in `psql -U $USERNAME -At -c "$QUERY" -h $HOST postgres`
do
    echo "Creating Db "$line"..."
    export PGPASSWORD="$LOCAL_PASSWORD"
    createdb -h $LOCAL_HOSTNAME -U $LOCAL_USERNAME -p $LOCAL_PORT  $line
    echo "Dumping "$line"..."
    export PGPASSWORD="$PASSWORD"
    pg_dump -U $USERNAME  -h $HOST "$line" > $DIR_PATH"$line-$FILE_NAME"_FULL.dump
    echo "Restoring "$line"..."
    export PGPASSWORD="$LOCAL_PASSWORD"
    psql -h $LOCAL_HOSTNAME -U $LOCAL_USERNAME -p $LOCAL_PORT  $line < $DIR_PATH"$line-$FILE_NAME"_FULL.dump
done