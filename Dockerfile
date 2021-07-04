ARG postgresql_version=13
FROM postgres:$postgresql_version as base
LABEL Authors="MEDIC SRE TEAM<devops@medic.org>"
COPY init-user-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-user-db.sh
