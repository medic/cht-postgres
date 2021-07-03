# CHT Postgres

Dockerfile for generating the PostgreSQL image used with [cht-couch2pg](https://github.com/medic/cht-couch2pg) to save read-only replicas of CouchDB data.

## Building The Image

To build an image, you need to choose the version of PostgreSQL [version](https://hub.docker.com/_/postgres) that you plan to use as the base image and then run docker build with that version. An example for PostgreSQL 13 is shown below.

```bash
docker build -t cht-postgres-13 --build-arg postgresql_version=13 .
```

## Running a container of the image

To run a container of this image, you will need to provide the prerequisite environment variables that are used to create the default user groups and permisions.

*Warning:* The environment vaiables only have an effect if you start the container with an empty data directory; any pre-existing database will not be altered at conatiner startup. This means that you can not change these variables and re-run the container hoping to change the variables.  If you would like to change the values contained in these variables after you create the database at the first contaner run, you will need to have recourse to the [psql](https://www.postgresql.org/docs/13/app-psql.html) terminal commands inside the container.

### Prerequisite Environment Variables

#### 1. POSTGRES_PASSWORD

This environment varaible sets the superuser password for PostgreSQL.

#### 2. POSTGRES_USER

This variable creates the specified user with superuser power.

#### 3. POSTGRES_DB

This sets the default database that will be used to to store the couchdb replicas.

#### 4. DB_OWNER_GROUP

This sets the default user role that will own the database. Use thius role to grant previleges to other users that will access the database.

#### 5. COUCH2PG_USER

This sets the user that will be used to insert read-only replicas of CouchDB data.

#### 6. COUCH2PG_USER_PASSWORD

This sets the password of the COUCH2PG_USER.
