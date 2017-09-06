create user x3ddashadmin identified by x3ddashadmin;
grant ALL privileges to x3ddashadmin;
CREATE SMALLFILE TABLESPACE "x3ddashadmin" LOGGING DATAFILE 'D:\Oracle\oradata\V6R2017X\x3ddashadmin.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
ALTER USER x3ddashadmin default tablespace "x3ddashadmin";
ALTER USER x3ddashadmin QUOTA UNLIMITED ON "x3ddashadmin";