/*
|| Script:	VEVO_CreateTablespaces.sql
|| Purpose:	Builds tablespaces (if necessary) to contain the VEVO schema.
|| Author:	Jim Czuprynski
|| Version: 2.0
*/

DROP TABLESPACE vevo_data INCLUDING CONTENTS AND DATAFILES;
CREATE BIGFILE TABLESPACE vevo_data
    DATAFILE '+DATA'
--  DATAFILE '/u02/app/oracle/oradata/ORA18C/PDBVEVO/vevo_data.dbf' 
    SIZE 256M REUSE
    AUTOEXTEND ON
    PERMANENT
    LOGGING
    EXTENT MANAGEMENT LOCAL
    SEGMENT SPACE MANAGEMENT AUTO
;

DROP TABLESPACE vevo_idx INCLUDING CONTENTS AND DATAFILES;
CREATE BIGFILE TABLESPACE vevo_idx
    DATAFILE '+DATA'
--  DATAFILE '/u02/app/oracle/oradata/ORA18C/PDBVEVO/vevo_idx.dbf' 
    SIZE 256M REUSE
    AUTOEXTEND ON
    PERMANENT
    LOGGING
    EXTENT MANAGEMENT LOCAL
    SEGMENT SPACE MANAGEMENT AUTO
;

