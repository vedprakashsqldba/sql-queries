-- Step 0:  Create Login on Master Database
CREATE login  OMSDEV1_IN_GGN WITH PASSWORD = '?f7h)Lp4<A2s';



-- Step 1: Create the custom role
CREATE ROLE Developer_omsdev1_IN;


-- Step 2: Grant INSERT and UPDATE permissions to the role
GRANT INSERT, UPDATE TO Developer_omsdev1_IN;

-- Step 3: Deny DDL permissions to the role
DENY ALTER, CREATE, DROP TO Developer_omsdev1_IN;

-- Step 4: Create the user and add them to the custom role
CREATE USER OMSDEV1_IN_GGN from login OMSDEV1_IN_GGN with default_Schema=dbo;
ALTER ROLE Developer_omsdev1_IN ADD MEMBER OMSDEV1_IN_GGN;

