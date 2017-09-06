
create user x3dpassadmin identified by x3dpassadmin; 
grant CREATE PUBLIC SYNONYM to x3dpassadmin; 
grant CREATE SEQUENCE to x3dpassadmin; 
grant CREATE SESSION to x3dpassadmin; 
grant CREATE SYNONYM to x3dpassadmin; 
grant CREATE TABLE to x3dpassadmin;
grant DROP PUBLIC SYNONYM to x3dpassadmin; 

CREATE SMALLFILE TABLESPACE "x3dpassadmin" LOGGING DATAFILE 'D:\Oracle\oradata\V6R2017X\passdb.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO; 
ALTER USER x3dpassadmin default tablespace "x3dpassadmin"; 

ALTER USER x3dpassadmin QUOTA UNLIMITED ON "x3dpassadmin";
ALTER USER x3dpassadmin QUOTA UNLIMITED ON USERS;


create user x3dpasstokens identified by x3dpasstokens; 
grant CREATE PUBLIC SYNONYM to x3dpasstokens; 
grant CREATE SEQUENCE to x3dpasstokens; 
grant CREATE SESSION to x3dpasstokens; 
grant CREATE SYNONYM to x3dpasstokens; 
grant CREATE TABLE to x3dpasstokens;
grant DROP PUBLIC SYNONYM to x3dpasstokens;

CREATE SMALLFILE TABLESPACE "x3dpasstokens" LOGGING DATAFILE 'D:\Oracle\oradata\V6R2017X\passtkdb.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO; 

ALTER USER x3dpasstokens default tablespace "x3dpasstokens"; 
ALTER USER x3dpasstokens QUOTA UNLIMITED ON "x3dpasstokens";