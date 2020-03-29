/*
|| Script:	VEVO_Create_Users.sql
|| Purpose:	Builds schema owner and other users for the VEVO schema
|| Author:	Jim Czuprynski
|| Version: 2.0
*/


/*
|| Create VEVO schema owner
*/

DROP USER vevo CASCADE;
CREATE USER vevo
    IDENTIFIED BY "D3m0_Cracy#"
    -- NO AUTHENTICATION
    DEFAULT TABLESPACE vevo_data
    TEMPORARY TABLESPACE temp
    PROFILE DEFAULT
    QUOTA UNLIMITED ON sysaux
    QUOTA UNLIMITED ON vevo_data
    QUOTA UNLIMITED ON vevo_idx
;

GRANT CONNECT, RESOURCE TO vevo;
GRANT CREATE PROCEDURE TO vevo;
GRANT CREATE PUBLIC SYNONYM TO vevo;
GRANT CREATE SEQUENCE TO vevo;
GRANT CREATE SESSION TO vevo;
GRANT CREATE SYNONYM TO vevo;
GRANT CREATE TABLE TO vevo;
GRANT CREATE VIEW TO vevo;
GRANT DROP PUBLIC SYNONYM TO vevo;
GRANT EXECUTE ANY PROCEDURE TO vevo;
GRANT READ,WRITE ON DIRECTORY data_pump_dir TO vevo;

-- Enable editioning
GRANT CREATE ANY EDITION TO vevo;
GRANT DROP ANY EDITION TO vevo;
ALTER USER vevo ENABLE EDITIONS;

/*
|| Creates additional users
*/

-----
-- Create VEVODEV User
-----
DROP USER vevodev CASCADE;
CREATE USER vevodev
    IDENTIFIED BY vevodev
    DEFAULT TABLESPACE data
    TEMPORARY TABLESPACE temp
    PROFILE DEFAULT
    QUOTA UNLIMITED ON data
;

GRANT CREATE SESSION TO vevodev;
GRANT SELECT ON vevo.t_voters TO vevodev;
GRANT SELECT ON vevo.t_voting_results TO vevodev;
ALTER USER vevodev  ENABLE EDITIONS;

