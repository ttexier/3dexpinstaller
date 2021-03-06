USE master;
GO
create database "%PASSPORTDB%" COLLATE SQL_Latin1_General_CP1_CI_AS;;
GO
-- Create logins
CREATE LOGIN "%PASSPORTUSER%" WITH PASSWORD = '%PASSPORTUSERPASSWORD%';
GO
CREATE LOGIN "%PASSPORTADMINUSER%" WITH PASSWORD = '%PASSPORTADMINUSERPASSWORD%';
GO
USE "%PASSPORTDB%";
GO
-- Create users on correct DATABASE (after use) and with correct schema
--(schema can be created after it will not CREATE USER %PASSPORTUSER% FOR LOGIN %PASSPORTUSER% WITH DEFAULT_SCHEMA = passport;
CREATE USER "%PASSPORTUSER%" FOR LOGIN "%PASSPORTUSER%" WITH DEFAULT_SCHEMA = "%PASSPORTDB%";
GO
CREATE USER "%PASSPORTADMINUSER%" FOR LOGIN "%PASSPORTADMINUSER%" WITH DEFAULT_SCHEMA = "%PASSPORTDB%";
GO

USE "%PASSPORTDB%";
GO
-- Create schema
CREATE SCHEMA "%PASSPORTDB%" AUTHORIZATION "%PASSPORTADMINUSER%";
GO

USE "%PASSPORTDB%";
GO
-- Grant access
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::"%PASSPORTDB%" TO "%PASSPORTADMINUSER%";
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::"%PASSPORTDB%" TO "%PASSPORTUSER%";
GO
-- Creating passport token database
CREATE DATABASE "%PASSPORTTOKENSDB%" COLLATE SQL_Latin1_General_CP1_CI_AS;;
GO
CREATE LOGIN "%PASSPORTTOKENSUSER%" WITH PASSWORD = '%PASSPORTTOKENSUSERPASSWORD%';
GO
use "%PASSPORTTOKENSDB%";;
GO
CREATE USER "%PASSPORTTOKENSUSER%" FOR LOGIN "%PASSPORTTOKENSUSER%" WITH DEFAULT_SCHEMA = "%PASSPORTTOKENSDB%";
GO

use "%PASSPORTTOKENSDB%";;
GO
CREATE SCHEMA "%PASSPORTTOKENSDB%" AUTHORIZATION "%PASSPORTTOKENSUSER%";
GO
GRANT CREATE TABLE, ALTER, SELECT, INSERT, UPDATE, DELETE ON DATABASE::"%PASSPORTTOKENSDB%" TO "%PASSPORTTOKENSUSER%";
GO
