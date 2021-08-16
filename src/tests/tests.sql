
    -- Start transaction and plan the tests.
    BEGIN; -- Start the transaction



    -- Plan count should match the number of tests.
    SELECT plan(3);

    -- Run the tests

    -- Test if couch2pg user exists
    SELECT has_user( :'COUCH2PG_USER', 'Couch2pg user exists' );

    -- Test  if couch2pg user is member of db owner group ]
    SELECT is_member_of( :'DB_OWNER_GROUP', :'COUCH2PG_USER', 'Couch2pg user is member of DB owner group' );

    -- Test is db owner group is the ownser of the database
    SELECT db_owner_is ( :'POSTGRES_DB', :'POSTGRES_DB', 'DB owner group is owner of the main db' );

    -- Finish the tests and clean up.
    SELECT * FROM finish();
    ROLLBACK; -- We don’t commit the transaction, this means tests don’t change the database in anyway