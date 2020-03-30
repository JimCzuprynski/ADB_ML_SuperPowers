/*
|| Use these commands to set up credentials, etc. for loading VEVO tables
|| from OCI-based external files
*/

-----
-- Create a new Cloud credential
-----
EXEC DBMS_CLOUD.DROP_CREDENTIAL(credential_name => 'DEF_CRED_NAME');
BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'DEF_CRED_NAME',
    username => 'exadbma1@zerodefectcomputing.com',
    password => 'N0M0reKn0bs#' );
END;
/

-----
-- Create a new EXTERNAL table via DBMS_CLOUD. Note that a predefined permission 
-- URL is used here to access the pertinent external file(s)
-----
DROP TABLE admin.xt_voting_results;
BEGIN
   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'XT_VOTING_RESULTS',
    credential_name =>'DEF_CRED_NAME',
    file_uri_list => 'https://objectstorage.us-ashburn-1.oraclecloud.com/p/5L-dIxXNihB4Qa-tPmi54Sp4_eavvJL5yCJRxS09ZmU/n/zdcaudb/b/XTFILES/o/IL06_VotingResults_2020-02-09.txt',
    format => json_object('delimiter' value '|', 'ignoremissingcolumns' value 'true', 'skipheaders' value '1'),
    column_list => 'v_id    NUMBER
    ,v_precinct_name        VARCHAR2(08)       
    ,v_early_voted          VARCHAR2(01)       
    ,v_voted_2010           VARCHAR2(01)       
    ,v_voted_2012           VARCHAR2(01)       
    ,v_voted_2014           VARCHAR2(01)       
    ,v_voted_2016           VARCHAR2(01)       
    ,v_decl_primary_2010    VARCHAR2(01)       
    ,v_decl_primary_2012    VARCHAR2(01)       
    ,v_decl_primary_2014    VARCHAR2(01)       
    ,v_decl_primary_2016    VARCHAR2(01)       
    ,v_decl_primary_2018    VARCHAR2(01)'
 );
END;
/

-----
-- Validate the table, and if necessary, debug any errors by accessing the 
-- corresponding error logs
-----

EXEC DBMS_CLOUD.VALIDATE_EXTERNAL_TABLE(TABLE_name => 'XT_VOTING_RESULTS');

SELECT * FROM admin.validate$14_log;
SELECT * FROM admin.xt_voting_results where rownum <= 10;

-----
-- Finally, load VOTING_RESULTS table using EXTERNAL table as data source
-----

ALTER TABLE vevo.t_voting_results DROP CONSTRAINT vr_pk;
ALTER TABLE vevo.t_voting_results DROP CONSTRAINT vr_v_vr_fk;

TRUNCATE TABLE vevo.t_voting_results;

INSERT ALL
  WHEN v_voted_2010 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'GEN2010', (TO_DATE('2010-11-05','YYYY-MM-DD') - DECODE(v_voted_2010,'E',DBMS_RANDOM.VALUE(1,5),0)), v_precinct_name, SUBSTR('DRDIRRDDRR',DBMS_RANDOM.VALUE(1,10),1), v_voted_2010)
  WHEN v_voted_2012 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'GEN2012', (TO_DATE('2012-11-04','YYYY-MM-DD') - DECODE(v_voted_2012,'E',DBMS_RANDOM.VALUE(1,5),0)), v_precinct_name, SUBSTR('DRRRDDIRDR',DBMS_RANDOM.VALUE(1,10),1), v_voted_2012)
  WHEN v_voted_2014 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'GEN2014', (TO_DATE('2014-11-03','YYYY-MM-DD') - DECODE(v_voted_2014,'E',DBMS_RANDOM.VALUE(1,5),0)), v_precinct_name, SUBSTR('DDDIRRRDDR',DBMS_RANDOM.VALUE(1,10),1), v_voted_2014)
  WHEN v_voted_2016 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'GEN2016', (TO_DATE('2016-11-08','YYYY-MM-DD') - DECODE(v_voted_2016,'E',DBMS_RANDOM.VALUE(1,5),0)), v_precinct_name, SUBSTR('RRRDDDIRDD',DBMS_RANDOM.VALUE(1,10),1), v_voted_2016)
  WHEN v_decl_primary_2010 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'PRI2010', TO_DATE('2010-03-01','YYYY-MM-DD'), v_precinct_name, v_decl_primary_2010, 'P')
  WHEN v_decl_primary_2012 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'PRI2012', TO_DATE('2012-03-01','YYYY-MM-DD'), v_precinct_name, v_decl_primary_2012, 'P')
  WHEN v_decl_primary_2014 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'PRI2014', TO_DATE('2014-03-01','YYYY-MM-DD'), v_precinct_name, v_decl_primary_2014, 'P')
  WHEN v_decl_primary_2016 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'PRI2016', TO_DATE('2016-03-21','YYYY-MM-DD'), v_precinct_name, v_decl_primary_2016, 'P')
  WHEN v_decl_primary_2018 IS NOT NULL THEN
    INTO vevo.t_voting_results  (vr_v_id, vr_election_abbr, vr_voted_dt, vr_voting_precinct, vr_party_abbr, vr_voting_method)
    VALUES (v_id, 'PRI2018', TO_DATE('2018-03-01','YYYY-MM-DD'), v_precinct_name, v_decl_primary_2018, 'P')
SELECT * 
  FROM admin.xt_voting_results
 ORDER BY v_id
;

COMMIT;
