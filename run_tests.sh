#! /bin/bash
set -e
/bin/bash /tests/entrypoint.sh postgres

export PGPASSWORD=$POSTGRES_PASSWORD
su postgres -c 'postgres' &
#waiting for postgres
until  pg_isready -q  -U $POSTGRES_USER -d $POSTGRES_DB
do
  echo "Waiting for PostgreSQL to start " >&2
  sleep 5
done


psql -h $POSTGRES_HOST -U cht -xf /tests/tests.sql --variable=DB_OWNER_GROUP="$DB_OWNER_GROUP" --variable=COUCH2PG_USER="$COUCH2PG_USER" --variable=POSTGRES_DB="$POSTGRES_DB"