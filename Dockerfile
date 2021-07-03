ARG postgresql_version=13
FROM postgres:$postgresql_version as base
LABEL Authors="MEDIC SRE TEAM<devops@medic.org>"
COPY init-user-db.sh /docker-entrypoint-initdb.d/init-user-db.sh
RUN chmod +x /docker-entrypoint-initdb.d/init-user-db.sh

# test image build
FROM base as test-buld
COPY install-pg-tap.sh  /docker-entrypoint-initdb.d/install-pg-tap.sh
RUN chmod +x /docker-entrypoint-initdb.d/install-pg-tap.sh

#install pgtap depedencies
RUN apt-get update \
    && apt-get install -y build-essential git-core libv8-dev curl postgresql-server-dev-$PG_MAJOR \
    && rm -rf /var/lib/apt/lists/*
    # install pgtap
RUN git clone --branch v1.1.0 git://github.com/theory/pgtap.git \
    && cd pgtap \
    && make \
    && make install
