#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" --variable=POSTGRES_DB="$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS pgtap;

EOSQL
