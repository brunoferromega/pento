#!/bin/bash
/docker-entrypoint-initdb.d/multiple-databases.sh

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE pento_dev;
    GRAN ALL PREVILEGES ON DATABASE pento_dev TO $POSTGRES_USER;
EOSQL


