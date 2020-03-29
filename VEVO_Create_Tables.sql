o/*
|| Script:	VEVO_Create_Tables.sql
|| Purpose:	Builds tables, editioning views, and any other required objects to 
||          create and eventually load the VEVO schema
|| Author:	Jim Czuprynski
|| Version: 2.0
*/

/*
|| Create Tables:
*/

DROP TABLE vevo.t_campaign_org PURGE;
DROP TABLE vevo.t_voting_results PURGE;
DROP TABLE vevo.t_staff PURGE;
DROP TABLE vevo.t_voters PURGE;
DROP TABLE vevo.t_canvassing PURGE;

-----
-- Table: T_VOTERS
-----
CREATE TABLE vevo.t_voters(
     v_id                   NUMBER(8,0)         NOT NULL
    ,v_state_voter_id       VARCHAR2(08)        NOT NULL
    ,v_last_name            VARCHAR2(40)        NOT NULL
    ,v_first_name           VARCHAR2(40)        NOT NULL
    ,v_middle_name          VARCHAR2(40)
    ,v_name_suffix          VARCHAR2(10)
    ,v_gender               VARCHAR2(01)
    ,v_situs_address        VARCHAR2(80)        NOT NULL
    ,v_situs_city           VARCHAR2(40)        NOT NULL
    ,v_situs_state_abbr     VARCHAR2(02)        NOT NULL
    ,v_situs_zip5           VARCHAR2(05)        NOT NULL
    ,v_situs_zip4           VARCHAR2(04)
    ,v_situs_longitude      NUMBER
    ,v_situs_latitude       NUMBER
    ,v_phone_nbr            VARCHAR2(15)        
    ,v_email_addr           VARCHAR2(60)
    ,v_age                  NUMBER(3,0)         NOT NULL
    ,v_dob                  DATE                NOT NULL
    ,v_race_designation     VARCHAR2(20)        NOT NULL
    ,v_last_registered      DATE                NOT NULL
    ,v_orig_registered      DATE                NOT NULL
    ,v_likely_party         VARCHAR2(02)        NOT NULL
    ,v_precinct_name        VARCHAR2(40)       
    ,v_county_name          VARCHAR2(40)       
    ,v_city_name            VARCHAR2(40)       
    ,v_township_name        VARCHAR2(40)       
    ,v_last_updated         DATE                NOT NULL
)
    TABLESPACE vevo_data
    STORAGE (INITIAL 8M NEXT 8M)
;

COMMENT ON TABLE vevo.t_voters
	IS 'Registered Voters';
COMMENT ON COLUMN vevo.t_voters.v_id
	IS 'Voter Unique ID, based on NGP/VAN Voter Affinity Abbreviation Code';
COMMENT ON COLUMN vevo.t_voters.v_state_voter_id
	IS 'Unique voter ID for voter within his(er) state';
COMMENT ON COLUMN vevo.t_voters.v_last_name
	IS 'Voter Last Name';
COMMENT ON COLUMN vevo.t_voters.v_first_name
	IS 'Voter First Name';
COMMENT ON COLUMN vevo.t_voters.v_middle_name
	IS 'Voter Middle Name (if it exists)';
COMMENT ON COLUMN vevo.t_voters.v_name_suffix
	IS 'Voter Name Suffix (if it exists)';
COMMENT ON COLUMN vevo.t_voters.v_gender
	IS 'Voter Gender';
COMMENT ON COLUMN vevo.t_voters.v_situs_address
	IS 'Voter Legal Address Line';
COMMENT ON COLUMN vevo.t_voters.v_situs_city
	IS 'Voter Legal Address City';
COMMENT ON COLUMN vevo.t_voters.v_situs_state_abbr
	IS 'Voter Legal Address State Abbreviation';
COMMENT ON COLUMN vevo.t_voters.v_situs_zip5
	IS 'Voter Legal Address 5-Digit ZIP Code';
COMMENT ON COLUMN vevo.t_voters.v_situs_zip4
	IS 'Voter Legal Address ZIP+4 Code';
 COMMENT ON COLUMN vevo.t_voters.v_situs_longitude
	IS 'Voter Legal Address Longitude';
 COMMENT ON COLUMN vevo.t_voters.v_situs_latitude
	IS 'Voter Legal Address Latitude';
COMMENT ON COLUMN vevo.t_voters.v_phone_nbr
	IS 'Voter Preferred Contact Phone Number ';
COMMENT ON COLUMN vevo.t_voters.v_email_addr
	IS 'Voter Preferred Contact E-Mail Address';
COMMENT ON COLUMN vevo.t_voters.v_dob
	IS 'Voter Date of Birth';
COMMENT ON COLUMN vevo.t_voters.v_age
	IS 'Voter Age (as of survey date)';
COMMENT ON COLUMN vevo.t_voters.v_race_designation
  IS 'Voter Race Designation';
COMMENT ON COLUMN vevo.t_voters.v_last_registered
	IS 'Date on which voter last registered to vote';
COMMENT ON COLUMN vevo.t_voters.v_orig_registered
	IS 'Date on which voter originally registered to vote';
COMMENT ON COLUMN vevo.t_voters.v_precinct_name
	IS 'Voter Precinct Name';
COMMENT ON COLUMN vevo.t_voters.v_county_name  
	IS 'Voter County of Residence';
COMMENT ON COLUMN vevo.t_voters.v_city_name    
	IS 'Voter City Name';
COMMENT ON COLUMN vevo.t_voters.v_township_name
	IS 'Voter Township Name';
COMMENT ON COLUMN vevo.t_voters.v_last_updated
	IS 'Date on which voter information was last updated';

-----
-- Table: T_STAFF
-----
CREATE TABLE vevo.t_staff(
     st_sk                  NUMBER(6,0)         NOT NULL
    ,st_last_name           VARCHAR2(40)        NOT NULL
    ,st_first_name          VARCHAR2(40)        NOT NULL
    ,st_initial             VARCHAR2(01)
    ,st_gender              VARCHAR2(01)        NOT NULL
    ,st_address             VARCHAR2(40)        NOT NULL
    ,st_city                VARCHAR2(40)        NOT NULL
    ,st_state_abbr          VARCHAR2(02)        NOT NULL
    ,st_zip                 VARCHAR2(09)        NOT NULL
    ,st_phone_nbr           VARCHAR2(10)        NOT NULL
    ,st_email_addr          VARCHAR2(60)        NOT NULL
    ,st_status              CHAR(1)             DEFAULT 'A'     NOT NULL
    ,st_join_dt             DATE                DEFAULT SYSDATE NOT NULL
    ,st_term_dt             DATE
    ,st_comments            VARCHAR2(4000)      DEFAULT 'New member'
)
    TABLESPACE vevo_data
    STORAGE (INITIAL 8M NEXT 8M)
;

COMMENT ON TABLE vevo.t_staff
	IS 'Campaign Staffers';
COMMENT ON COLUMN vevo.t_staff.st_sk
	IS 'Staffer Unique ID. Sequence number assigned when staffer entry created';
COMMENT ON COLUMN vevo.t_staff.st_last_name
	IS 'Staffer Last Name';
COMMENT ON COLUMN vevo.t_staff.st_first_name
	IS 'Staffer First Name';
COMMENT ON COLUMN vevo.t_staff.st_initial
	IS 'Staffer Middle Initial (if one exists)';
COMMENT ON COLUMN vevo.t_staff.st_gender
	IS 'Staffer Gender';
COMMENT ON COLUMN vevo.t_staff.st_address
	IS 'Staffer Address';
COMMENT ON COLUMN vevo.t_staff.st_city
	IS 'Staffer City';
COMMENT ON COLUMN vevo.t_staff.st_state_abbr
	IS 'Staffer State Abbreviation';
COMMENT ON COLUMN vevo.t_staff.st_zip
	IS 'Staffer ZIP Code ';
COMMENT ON COLUMN vevo.t_staff.st_phone_nbr
	IS 'Staffer Telephone Number';
COMMENT ON COLUMN vevo.t_staff.st_email_addr
	IS 'Staffer E-Mail Address';
COMMENT ON COLUMN vevo.t_staff.st_status
	IS 'Staffer Status';
COMMENT ON COLUMN vevo.t_staff.st_join_dt
	IS 'Date on which Staffer joined the campaign';
COMMENT ON COLUMN vevo.t_staff.st_term_dt
	IS 'Date on which Staffer left or otherwise exited from the campaign';
COMMENT ON COLUMN vevo.t_staff.st_comments
	IS 'Comments about Staffer';

-----
-- Table: T_VOTING_RESULTS
-----
CREATE TABLE vevo.t_voting_results(
     vr_v_id                NUMBER(8,0)        NOT NULL
    ,vr_election_abbr       VARCHAR2(07)       NOT NULL
    ,vr_voted_dt            DATE               NOT NULL
    ,vr_voting_precinct     VARCHAR2(08)       NOT NULL
    ,vr_party_abbr          VARCHAR2(03)       NOT NULL
    ,vr_voting_method       VARCHAR2(08)       NOT NULL
)
    TABLESPACE vevo_data
    STORAGE (INITIAL 8M NEXT 8M)
    PARTITION BY RANGE(vr_voted_dt)
    INTERVAL(NUMTOYMINTERVAL(1, 'YEAR'))
    (
        PARTITION vr_oldest
            VALUES LESS THAN (TO_DATE('2005-01-01', 'yyyy-mm-dd'))
    )
;

COMMENT ON TABLE vevo.t_voting_results
	IS 'Voting Results, gleaned from publicly-available sources';
COMMENT ON COLUMN vevo.t_voting_results.vr_v_id
	IS 'Voter Unique ID, based on NGP/VAN Voter Affinity Abbreviation Code';
COMMENT ON COLUMN vevo.t_voting_results.vr_election_abbr
	IS 'Abbreviation for election tht voter participated in';
COMMENT ON COLUMN vevo.t_voting_results.vr_voted_dt
	IS 'Date on which voter voted in an election';
COMMENT ON COLUMN vevo.t_voting_results.vr_voting_precinct
	IS 'Precinct in which voter voted in election';
COMMENT ON COLUMN vevo.t_voting_results.vr_party_abbr
	IS 'The party that the voter declared; typically only required for primary voting';
COMMENT ON COLUMN vevo.t_voting_results.vr_voting_method
	IS 'The method the voter used to vote (e.g. by mail, by absentee ballot, at precinct on day of election)';

-----
-- Table: T_CANVASSING
-----
CREATE TABLE vevo.t_canvassing(
     cv_v_id                    NUMBER(8,0)         NOT NULL
    ,cv_st_sk                   NUMBER(6,0)         NOT NULL
    ,cv_date                    DATE                DEFAULT SYSDATE NOT NULL
    ,cv_location                CHAR(1)             DEFAULT 'H'     NOT NULL
    ,cv_candidate_afnt          CHAR(1)             DEFAULT '3'     NOT NULL
    ,cv_enthusiasm_rtg          CHAR(1)             DEFAULT '3'     NOT NULL
    ,cv_volunteerism_rtg        CHAR(1)             DEFAULT 'Y'     NOT NULL
    ,cv_contribution_rtg        CHAR(1)             DEFAULT 'Y'     NOT NULL
    ,cv_follow_up_rtg           CHAR(1)             DEFAULT 'Y'     NOT NULL
    ,cv_dnr_flg                 CHAR(1)             DEFAULT 'N'     NOT NULL
    ,cv_comments                VARCHAR2(4000)      NOT NULL
)
    TABLESPACE vevo_data
    STORAGE (INITIAL 8M NEXT 8M)
;

COMMENT ON TABLE vevo.t_canvassing
	IS 'Canvassing Tracking';
COMMENT ON COLUMN vevo.t_canvassing.cv_v_id
	IS 'Voter Unique ID, based on NGP/VAN Voter Affinity Abbreviation Code';
COMMENT ON COLUMN vevo.t_canvassing.cv_st_sk
	IS 'Canvassing Staffer Unique ID';
COMMENT ON COLUMN vevo.t_canvassing.cv_date
	IS 'Canvassing Date';
COMMENT ON COLUMN vevo.t_canvassing.cv_location
	IS 'Canvassing Location';
COMMENT ON COLUMN vevo.t_canvassing.cv_candidate_afnt
	IS 'Candidate Affinity Code. 1 = Low, 5 = High';
COMMENT ON COLUMN vevo.t_canvassing.cv_enthusiasm_rtg
	IS 'Candidate Enthusiasm Rating. 1 = Low, 5 = High';
COMMENT ON COLUMN vevo.t_canvassing.cv_volunteerism_rtg
	IS 'Willing to Volunteer Flag. (Y)es/(N)o';
COMMENT ON COLUMN vevo.t_canvassing.cv_contribution_rtg
	IS 'Willing to Contribute Flag. (Y)es/(N)o';
COMMENT ON COLUMN vevo.t_canvassing.cv_follow_up_rtg
	IS 'Follow-Up Requested Flag. (Y)es/(N)o';
COMMENT ON COLUMN vevo.t_canvassing.cv_dnr_flg
	IS 'Do Not Recontact Flag. (Y)es/(N)o';
COMMENT ON COLUMN vevo.t_canvassing.cv_comments
	IS 'Canvasser Comments / Observations';

-----
-- Table: T_CAMPAIGN_ORG
-----
CREATE TABLE vevo.t_campaign_org(
     co_st_sk               NUMBER(6,0)                     NOT NULL
    ,co_hier_sk             NUMBER(6,0)                     NOT NULL
    ,co_beg_dt              DATE                            NOT NULL
    ,co_role                VARCHAR2(20)                    NOT NULL
    ,co_status              CHAR(1)         DEFAULT 'A'     NOT NULL
    ,co_end_dt              DATE
)
    TABLESPACE vevo_data
    STORAGE (INITIAL 8M NEXT 8M)
;

COMMENT ON TABLE vevo.t_campaign_org
	IS 'Campaign Organization Hierarchy. Controls the assignment of roles to and relationships between various staff resources over time';

COMMENT ON COLUMN vevo.t_campaign_org.co_st_sk
	IS 'Staffer Unique ID';
COMMENT ON COLUMN vevo.t_campaign_org.co_hier_sk
	IS 'The unique ID of the staffer to whom (s)he reports';
COMMENT ON COLUMN vevo.t_campaign_org.co_beg_dt
	IS 'Staffing Assignment Begin Date';
COMMENT ON COLUMN vevo.t_campaign_org.co_role
	IS 'Staffing Assignment Role Designator';
COMMENT ON COLUMN vevo.t_campaign_org.co_status
	IS 'Status Indicator';
COMMENT ON COLUMN vevo.t_campaign_org.co_end_dt
	IS 'Staffing Assignment End Date. If NULL, this assignment is still active';

-----
-- Create Editioning Views
-----
CONNECT vevo/vevo@pdbvevo;

CREATE OR REPLACE EDITIONING VIEW vevo.voters AS
SELECT
     v_id
    ,v_state_voter_id
    ,v_last_name
    ,v_first_name
    ,v_middle_name
    ,v_name_suffix
    ,v_gender
    ,v_situs_address
    ,v_situs_city
    ,v_situs_state_abbr
    ,v_situs_zip5
    ,v_situs_zip4
    ,v_situs_longitude
    ,v_situs_latitude
    ,v_phone_nbr
    ,v_email_addr
    ,v_age
    ,v_dob
    ,v_race_designation
    ,v_last_registered
    ,v_orig_registered
    ,v_likely_party
    ,v_precinct_name
    ,v_county_name
    ,v_city_name
    ,v_township_name
    ,v_last_updated
  FROM vevo.t_voters;

CREATE OR REPLACE EDITIONING VIEW vevo.staff AS
SELECT
     st_sk
    ,st_last_name
    ,st_first_name
    ,st_initial
    ,st_gender
    ,st_address
    ,st_city
    ,st_state_abbr
    ,st_zip
    ,st_phone_nbr
    ,st_email_addr
    ,st_status
    ,st_join_dt
    ,st_term_dt
    ,st_comments
  FROM vevo.t_staff;

CREATE OR REPLACE EDITIONING VIEW vevo.voting_results AS
SELECT
     vr_v_id
    ,vr_election_abbr
    ,vr_voted_dt
    ,vr_voting_precinct
    ,vr_party_abbr
    ,vr_voting_method
  FROM vevo.t_voting_results;

CREATE OR REPLACE EDITIONING VIEW vevo.canvassing AS
SELECT
     cv_v_id
    ,cv_st_sk
    ,cv_date
    ,cv_location
    ,cv_candidate_afnt
    ,cv_enthusiasm_rtg
    ,cv_volunteerism_rtg
    ,cv_contribution_rtg
    ,cv_follow_up_rtg
    ,cv_dnr_flg
    ,cv_comments
  FROM vevo.t_canvassing;

CREATE OR REPLACE EDITIONING VIEW vevo.campaign_org AS
SELECT
     co_st_sk
    ,co_hier_sk
    ,co_beg_dt
    ,co_role
    ,co_status
    ,co_end_dt
  FROM vevo.t_campaign_org;


/*
-----
-- Verify editioned views and objects
-----
SET LINESIZE 130
SET PAGESIZE 20000
COL owner FORMAT A12
COL object_type FORMAT A20
COL object_name FORMAT A32
SELECT
    owner
   ,object_name
   ,object_type
   ,status
   ,edition_name
  FROM all_objects
 WHERE owner = 'VEVO'
 AND edition_name IS NOT NULL
 ORDER BY 1,2,3;
*/


