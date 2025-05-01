/*
Create a master key to protect the secret of the credential
*/
IF NOT EXISTS (
              SELECT 1
              FROM sys.symmetric_keys
              WHERE name = '##MS_DatabaseMasterKey##'
              )
CREATE MASTER KEY;

/*
(Re-)create a database scoped credential.
The name of the credential must match the URL of the blob container.
*/
IF EXISTS (
          SELECT 1
          FROM sys.database_credentials
          WHERE name = 'https://omsextendedevents.blob.core.windows.net/omsdatabase-eventlogs'
          )
    DROP DATABASE SCOPED CREDENTIAL [https://omsextendedevents.blob.core.windows.net/omsdatabase-eventlogs];

/*
The secret is the SAS token for the container. The Read, Write, and List permissions are set.
*/
CREATE DATABASE SCOPED CREDENTIAL [https://omsextendedevents.blob.core.windows.net/omsdatabase-eventlogs]
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
     SECRET = 'sp=rwl&st=2024-09-09T12:06:13Z&se=2024-09-09T20:06:13Z&spr=https&sv=2022-11-02&sr=c&sig=RPgLZC30s%2FcmfD%2BQCJ1UKKDYygewYQ1EY2LZsrAzqA0%3D';