#!/bin/bash
USERNAME=$1
PASSWORD=$2
HOST=subsbase-dev-db-13.postgres.database.azure.com
LOCAL_HOSTNAME=localhost
LOCAL_USERNAME=$3
LOCAL_PORT=$4
LOCAL_PASSWORD=$5
DIRECTORY=$6
RANDOM_CODE=$RANDOM
DATE=$(date +%Y-%m-%d) 
FILE_NAME="$DATE-$RANDOM_CODE"
QUERY="SELECT datname FROM pg_database WHERE datname LIKE 'subsbase-%';"
export PGPASSWORD="$PASSWORD"
current=$PWD
echo current
mkdir $DIRECTORY 
for line in `psql -U $USERNAME -At -c "$QUERY" -h $HOST postgres`
do
    echo "Creating Db "$line"..."
    createdb -h $LOCAL_HOSTNAME -U $LOCAL_USERNAME -p $LOCAL_PORT  $line
    echo "Dumping "$line"..."
    pg_dump -U $USERNAME  -h $HOST "$line" > $current/$DIRECTORY/"$line-$FILE_NAME"_FULL.dump 
    echo "Restoring "$line"..."
    psql -h $LOCAL_HOSTNAME -U $LOCAL_USERNAME -p $LOCAL_PORT  $line < $current/$DIRECTORY/"$line-$FILE_NAME"_FULL.dump
done