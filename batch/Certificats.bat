@echo off

rem Description: this batch will create and import certificates.  First you must:
rem Step 1: Install Apache webserver with Openssl. You can download it at https://archive.apache.org/dist/httpd/binaries/win32/httpd-2.2.22-win32-x86-openssl-0.9.8t.msi
rem Step 2: Change the path below to your Apache webserver bin directory
rem %APACHE_HOME%
rem %JAVAHOME64%
rem %JREHOME64%

rem %JAVAHOME32%
rem %JREHOME32%



rem %PASSWORD%
rem %PASSPORT%
rem %SPACE%
rem %DASHBOARD%
rem %UNTRUSTED%
rem %SEARCH%
rem %SWYM%
rem %COMMENT%
rem %NOTIFICATION%

rem %SSLDIR%
rem %C%
rem %ST%
rem %L%
rem %O%


set APACHE_HOME=%APACHE_HOME%
rem Step 3: Define below where you want to have your JDK installed

set JAVA_HOME64=%JAVAHOME64%
set JRE_HOME64=%JREHOME64%

set JAVA_HOME32=%JAVAHOME32%
set JRE_HOME32=%JREHOME32%

set OPENSSL_CONF=%APACHE_HOME%\conf\openssl.cnf 



>certificates.log (

rem Creates %SSLDIR% folder, creates certificates in that folder, and imports to jre keystores (both private and public)

md %SSLDIR%\crt

cd %APACHE_HOME%\bin

openssl genrsa -des3 -passout pass:%PASSWORD% -out %SSLDIR%\CA.key 2048

openssl req -config %APACHE_HOME%\conf\openssl.cnf -new -x509 -subj "/C=%C%/ST=%ST%/L=%L%/O=%O%/CN=CA_CERT_KEONYS" -days 3000 -key %SSLDIR%\CA.key -out %SSLDIR%\crt\CA.crt -passin pass:%PASSWORD%

openssl genrsa 2048 > %SSLDIR%\3dserver.key

rem 3Dpassport

openssl req -config %APACHE_HOME%\conf\openssl.cnf -new -subj "/C=%C%/ST=%ST%/L=%L%/O=%O%/CN=%PASSPORT%" -key %SSLDIR%\3dserver.key -out %SSLDIR%\3dpassport.csr

openssl x509 -days 3000 -req -in %SSLDIR%\3dpassport.csr -out %SSLDIR%\crt\3dpassport.crt -CA %SSLDIR%\crt\CA.crt -CAkey %SSLDIR%\CA.key -CAcreateserial -CAserial ca.srl -passin pass:%PASSWORD%

rem 3dspace

openssl req -config %APACHE_HOME%\conf\openssl.cnf -new -subj "/C=%C%/ST=%ST%/L=%L%/O=%O%/CN=%SPACE%" -key %SSLDIR%\3dserver.key -out %SSLDIR%\3dspace.csr

openssl x509 -days 3000 -req -in %SSLDIR%\3dspace.csr -out %SSLDIR%\crt\3dspace.crt -CA %SSLDIR%\crt\CA.crt -CAkey %SSLDIR%\CA.key -CAcreateserial -CAserial ca.srl -passin pass:%PASSWORD%

rem 3ddashboard

openssl req -config %APACHE_HOME%\conf\openssl.cnf -new -subj "/C=%C%/ST=%ST%/L=%L%/O=%O%/CN=%DASHBOARD%" -key %SSLDIR%\3dserver.key -out %SSLDIR%\3ddashboard.csr

openssl x509 -days 3000 -req -in %SSLDIR%\3ddashboard.csr -out %SSLDIR%\crt\3ddashboard.crt -CA %SSLDIR%\crt\CA.crt -CAkey %SSLDIR%\CA.key -CAcreateserial -CAserial ca.srl -passin pass:%PASSWORD%

openssl req -config %APACHE_HOME%\conf\openssl.cnf -new -subj "/C=%C%/ST=%ST%/L=%L%/O=%O%/CN=%UNTRUSTED%" -key %SSLDIR%\3dserver.key -out %SSLDIR%\untrusted.3ddashboard.csr

openssl x509 -days 3000 -req -in %SSLDIR%\untrusted.3ddashboard.csr -out %SSLDIR%\crt\untrusted.3ddashboard.crt -CA %SSLDIR%\crt\CA.crt -CAkey %SSLDIR%\CA.key -CAcreateserial -CAserial ca.srl -passin pass:%PASSWORD%

rem 3dcomment

openssl req -config %APACHE_HOME%\conf\openssl.cnf -new -subj "/C=%C%/ST=%ST%/L=%L%/O=%O%/CN=%COMMENT%" -key %SSLDIR%\3dserver.key -out %SSLDIR%\3dcomment.csr

openssl x509 -days 3000 -req -in %SSLDIR%\3dcomment.csr -out %SSLDIR%\crt\3dcomment.crt -CA %SSLDIR%\crt\CA.crt -CAkey %SSLDIR%\CA.key -CAcreateserial -CAserial ca.srl -passin pass:%PASSWORD%

rem 3dsearch

openssl req -config %APACHE_HOME%\conf\openssl.cnf -new -subj "/C=%C%/ST=%ST%/L=%L%/O=%O%/CN=%SEARCH%" -key %SSLDIR%\3dserver.key -out %SSLDIR%\3dsearch.csr

openssl x509 -days 3000 -req -in %SSLDIR%\3dsearch.csr -out %SSLDIR%\crt\3dsearch.crt -CA %SSLDIR%\crt\CA.crt -CAkey %SSLDIR%\CA.key -CAcreateserial -CAserial ca.srl -passin pass:%PASSWORD%


rem import into 32 and 64 bits jre and jdk


rem 64 bits

rem ca cert

%JAVA_HOME64%\jre\bin\keytool -delete -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -alias CA_CERT_KEONYS
%JAVA_HOME64%\jre\bin\keytool -importcert -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\CA.crt -alias CA_CERT_KEONYS

%JRE_HOME64%\bin\keytool -delete -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -alias CA_CERT_KEONYS
%JRE_HOME64%\bin\keytool -importcert -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\CA.crt -alias CA_CERT_KEONYS

rem 3dpassport

%JAVA_HOME64%\jre\bin\keytool -delete -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dpassport
%JAVA_HOME64%\jre\bin\keytool -importcert -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dpassport.crt -alias 3Dpassport

%JRE_HOME64%\bin\keytool -delete -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dpassport
%JRE_HOME64%\bin\keytool -importcert -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dpassport.crt -alias 3Dpassport

rem 3dspace

%JAVA_HOME64%\jre\bin\keytool -delete -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dspace
%JAVA_HOME64%\jre\bin\keytool -importcert -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dspace.crt -alias 3Dspace

%JRE_HOME64%\bin\keytool -delete -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dspace
%JRE_HOME64%\bin\keytool -importcert -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dspace.crt -alias 3Dspace

rem 3ddashboard

%JAVA_HOME64%\jre\bin\keytool -delete -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Ddashboard
%JAVA_HOME64%\jre\bin\keytool -importcert -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3ddashboard.crt -alias 3Ddashboard

%JAVA_HOME64%\jre\bin\keytool -delete -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -alias untrusted3Ddashboard
%JAVA_HOME64%\jre\bin\keytool -importcert -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\untrusted.3ddashboard.crt -alias untrusted3Ddashboard

%JRE_HOME64%\bin\keytool -delete -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -alias 3Ddashboard
%JRE_HOME64%\bin\keytool -importcert -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3ddashboard.crt -alias 3Ddashboard

%JRE_HOME64%\bin\keytool -delete -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -alias untrusted3Ddashboard
%JRE_HOME64%\bin\keytool -importcert -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\untrusted.3ddashboard.crt -alias untrusted3Ddashboard

rem 3dcomment

%JAVA_HOME64%\jre\bin\keytool -delete -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dcomment
%JAVA_HOME64%\jre\bin\keytool -importcert -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dcomment.crt -alias 3Dcomment

%JRE_HOME64%\bin\keytool -delete -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dcomment
%JRE_HOME64%\bin\keytool -importcert -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dcomment.crt -alias 3dcomment

rem 3dsearch

%JAVA_HOME64%\jre\bin\keytool -delete -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dsearch
%JAVA_HOME64%\jre\bin\keytool -importcert -keystore %JAVA_HOME64%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dsearch.crt -alias 3Dsearch

%JRE_HOME64%\bin\keytool -delete -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dsearch
%JRE_HOME64%\bin\keytool -importcert -keystore %JRE_HOME64%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dsearch.crt -alias 3dsearch





rem 32 bits

rem ca cert

%JAVA_HOME32%\jre\bin\keytool -delete -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -alias CA_CERT_KEONYS
%JAVA_HOME32%\jre\bin\keytool -importcert -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\CA.crt -alias CA_CERT_KEONYS

%JRE_HOME32%\bin\keytool -delete -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -alias CA_CERT_KEONYS
%JRE_HOME32%\bin\keytool -importcert -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\CA.crt -alias CA_CERT_KEONYS

rem 3dpassport

%JAVA_HOME32%\jre\bin\keytool -delete -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dpassport
%JAVA_HOME32%\jre\bin\keytool -importcert -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dpassport.crt -alias 3Dpassport

%JRE_HOME32%\bin\keytool -delete -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dpassport
%JRE_HOME32%\bin\keytool -importcert -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dpassport.crt -alias 3Dpassport

rem 3dspace

%JAVA_HOME32%\jre\bin\keytool -delete -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dspace
%JAVA_HOME32%\jre\bin\keytool -importcert -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dspace.crt -alias 3Dspace

%JRE_HOME32%\bin\keytool -delete -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dspace
%JRE_HOME32%\bin\keytool -importcert -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dspace.crt -alias 3Dspace

rem 3ddashboard

%JAVA_HOME32%\jre\bin\keytool -delete -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Ddashboard
%JAVA_HOME32%\jre\bin\keytool -importcert -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3ddashboard.crt -alias 3Ddashboard

%JAVA_HOME32%\jre\bin\keytool -delete -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -alias untrusted3Ddashboard
%JAVA_HOME32%\jre\bin\keytool -importcert -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\untrusted.3ddashboard.crt -alias untrusted3Ddashboard

%JRE_HOME32%\bin\keytool -delete -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -alias 3Ddashboard
%JRE_HOME32%\bin\keytool -importcert -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3ddashboard.crt -alias 3Ddashboard

%JRE_HOME32%\bin\keytool -delete -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -alias untrusted3Ddashboard
%JRE_HOME32%\bin\keytool -importcert -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\untrusted.3ddashboard.crt -alias untrusted3Ddashboard

rem 3dcomment

%JAVA_HOME32%\jre\bin\keytool -delete -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dcomment
%JAVA_HOME32%\jre\bin\keytool -importcert -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dcomment.crt -alias 3Dcomment

%JRE_HOME32%\bin\keytool -delete -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dcomment
%JRE_HOME32%\bin\keytool -importcert -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dcomment.crt -alias 3dcomment

rem 3dsearch

%JAVA_HOME32%\jre\bin\keytool -delete -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -alias 3Dsearch
%JAVA_HOME32%\jre\bin\keytool -importcert -keystore %JAVA_HOME32%\jre\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dsearch.crt -alias 3Dsearch

%JRE_HOME32%\bin\keytool -delete -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -alias 3Dsearch
%JRE_HOME32%\bin\keytool -importcert -keystore %JRE_HOME32%\lib\security\cacerts -noprompt -storepass changeit -file %SSLDIR%\crt\3dsearch.crt -alias 3dsearch


)
