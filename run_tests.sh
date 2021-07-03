#! /bin/bash
set -e
apt-get update
apt-get -y install postgresql-client

export PGPASSWORD=$POSTGRES_PASSWORD

#waiting for postgres
until  pg_isready -q  -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DB
do
  echo "Waiting for PostgreSQL to start " >&2
  sleep 5
done


psql -h $POSTGRES_HOST -U cht -xf /tests/tests.sql --variable=DB_OWNER_GROUP="$DB_OWNER_GROUP" --variable=COUCH2PG_USER="$COUCH2PG_USER" --variable=POSTGRES_DB="$POSTGRES_DB"