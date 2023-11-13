select * from user_tables;
--주석(ctrl /)
--create - DDL 데이터 정의 명령어
CREATE user c##scott IDENTIFIED by tiger;
drop user c##scott;

alter SESSION set "_ORACLE_SCRIPT"=true;
CREATE user stream IDENTIFIED by stream;
GRANT connect,resource,dba to stream; 


CREATE user kh IDENTIFIED by kh;
CREATE user scott IDENTIFIED by tiger;

CREATE USER KHL IDENTIFIED BY KHL;
GRANT CONNECT, RESOURCE, DBA TO KHL;

CREATE USER KM IDENTIFIED BY KM;
GRANT CONNECT, RESOURCE, DBA TO KM;

GRANT connect,resource to stream;
GRANT connect,resource to c##scott;
GRANT connect,resource to kh; 
GRANT connect,resource to scott, kh; 

