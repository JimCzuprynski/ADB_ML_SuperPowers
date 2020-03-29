/*
-- Create credential
BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'DEF_CRED_NAME',
    username => 'exadbma1@zerodefectcomputing.com',
    password => 'L3tM31n_P13a$3' );
END;
/


-- Create external table
BEGIN
   DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
    table_name =>'XT_VOTING_RESULTS',
    credential_name =>'DEF_CRED_NAME',
    file_uri_list =>'https://objectstorage.us-ashburn-1.oraclecloud.com/n/zdcaudb/b/XTFILES/o/VotingResults20200209-4199742975.txt',
    format => json_object('delimiter' value '|'),
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
    ,v_decl_primary_2018    VARCHAR2(01)       
 );
END;
/

*/

-----
-- Table: XT_VOTERS
-----
DROP TABLE vevo.xt_voters;
CREATE TABLE vevo.xt_voters(
     v_id                   VARCHAR2(08)       
    ,v_state_voter_id       VARCHAR2(08)       
    ,v_last_name            VARCHAR2(40)       
    ,v_first_name           VARCHAR2(40)       
    ,v_middle_name          VARCHAR2(40)
    ,v_name_suffix          VARCHAR2(10)
    ,v_street_nbr           VARCHAR2(40)
    ,v_street_half          VARCHAR2(40)
    ,v_street_prefix        VARCHAR2(40)
    ,v_street_name          VARCHAR2(40)
    ,v_street_type          VARCHAR2(40)
    ,v_street_suffix        VARCHAR2(40)
    ,v_apt_type             VARCHAR2(40)
    ,v_apt_nbr              VARCHAR2(40)
    ,v_city                 VARCHAR2(40)       
    ,v_state_abbr           VARCHAR2(02)       
    ,v_zip_5                VARCHAR2(05)       
    ,v_zip_4                VARCHAR2(04)       
    ,v_age                  NUMBER(3,0)
    ,v_gender               VARCHAR2(01)
    ,v_dob                  DATE               
    ,v_coded_race           VARCHAR2(15)       
    ,v_phone_nbr            VARCHAR2(12)       
    ,v_email_address        VARCHAR2(64)       
    ,v_last_registered      DATE               
    ,v_orig_registered      DATE               
    ,v_likely_party         VARCHAR2(02)
    ,v_precinct_name        VARCHAR2(40)       
    ,v_county_name          VARCHAR2(40)       
    ,v_city_name            VARCHAR2(40)       
    ,v_township_name        VARCHAR2(40)       
)
  ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER 
    DEFAULT DIRECTORY XTFILES
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY NEWLINE
      SKIP 1
      FIELDS TERMINATED BY '|' (
         v_id                   CHAR(08)       
        ,v_state_voter_id       CHAR(08)       
        ,v_last_name            CHAR(40)       
        ,v_first_name           CHAR(40)       
        ,v_middle_name          CHAR(40)
        ,v_name_suffix          CHAR(10)
        ,v_street_nbr           CHAR(40)
        ,v_street_half          CHAR(40)
        ,v_street_prefix        CHAR(40)
        ,v_street_name          CHAR(40)
        ,v_street_type          CHAR(40)
        ,v_street_suffix        CHAR(40)
        ,v_apt_type             CHAR(40)
        ,v_apt_nbr              CHAR(40)
        ,v_city                 CHAR(40)       
        ,v_state_abbr           CHAR(02)       
        ,v_zip_5                CHAR(05)       
        ,v_zip_4                CHAR(04)       
        ,v_age                  CHAR(03)
        ,v_gender               CHAR(01)
        ,v_dob                  CHAR(10) DATE_FORMAT DATE MASK "MM/DD/YYYY"
        ,v_coded_race           CHAR(15)       
        ,v_phone_nbr            CHAR(12)       
        ,v_email_address        CHAR(64)       
        ,v_last_registered      CHAR(10) DATE_FORMAT DATE MASK "MM/DD/YYYY"
        ,v_orig_registered      CHAR(10) DATE_FORMAT DATE MASK "MM/DD/YYYY"
        ,v_likely_party         CHAR(02)
        ,v_precinct_name        CHAR(40)       
        ,v_county_name          CHAR(40)       
        ,v_city_name            CHAR(40)       
        ,v_township_name        CHAR(40)       
      )
    )
    LOCATION ('VoterDemographics20200209-14866137793.txt')
);


-- Sample of voter data:
SELECT v_id, v_gender, v_age, v_likely_party, v_zip_5 
  FROM vevo.xt_voters
 WHERE ROWNUM <= 50;

-- Any duplicate voters?
SELECT v_aff_nbr, COUNT(v_aff_nbr)
  FROM vevo.xt_voters
 GROUP BY v_aff_nbr
 HAVING COUNT(v_aff_nbr) > 1
 ORDER BY v_aff_nbr;
  
-- Sample demographics:
SELECT v_gender, v_age, v_likely_party, COUNT(*)
  FROM vevo.xt_voters
 WHERE v_gender IN ('M','F')
   AND v_age IS NOT NULL
 GROUP BY v_gender, v_age, v_likely_party
 ORDER BY v_gender, v_age, v_likely_party
;
  
SELECT v_county_name, v_situs_city, v_likely_party, COUNT(*)
  FROM vevo.xt_voters
 WHERE v_gender IN ('M','F')
   AND v_age IS NOT NULL
 GROUP BY v_county_name, v_situs_city, v_likely_party
 ORDER BY v_county_name, v_situs_city, v_likely_party
;

-- Precinct data:
SELECT v_precinct_id, v_precinct_name, COUNT(*) 
  FROM vevo.xt_voters 
 GROUP BY v_precinct_id, v_precinct_name
 ORDER BY v_precinct_id, v_precinct_name;
  
  
-----
-- Table: XT_VOTING_RESULTS
-----
DROP TABLE vevo.xt_voting_results;
CREATE TABLE vevo.xt_voting_results(
     v_id                   VARCHAR2(08)       
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
    ,v_decl_primary_2018    VARCHAR2(01)       
)
  ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER 
    DEFAULT DIRECTORY XTFILES
    ACCESS PARAMETERS (
      RECORDS DELIMITED BY DETECTED NEWLINE
      SKIP 1
      FIELDS TERMINATED BY "|" 
      MISSING FIELD VALUES ARE NULL
      (
         v_id                   
        ,v_precinct_name        
        ,v_early_voted          
        ,v_voted_2010           
        ,v_voted_2012           
        ,v_voted_2014           
        ,v_voted_2016           
        ,v_decl_primary_2010    
        ,v_decl_primary_2012    
        ,v_decl_primary_2014    
        ,v_decl_primary_2016    
        ,v_decl_primary_2018    
      )
    )
    LOCATION ('IL06_VotingResults_2020-02-09.txt')
);

