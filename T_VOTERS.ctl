-----
-- For new format from Votebuilder data
--     ,v_age                                    "NVL(:v_age,0)"  -- "NVL(:v_age, ROUND(SYSDATE - TO_DATE(:v_dob,'MM/DD/YYYY')),0)"
--     ,v_situs_address     CONSTANT   'Fill this later'
-----
OPTIONS (ROWS=100000, SKIP=1, DIRECT=TRUE)
LOAD DATA 
INFILE 'IL06_VoterDemographics_2020-02-09.txt ' "str '\r\n'"
TRUNCATE
INTO TABLE vevo.t_voters
FIELDS TERMINATED BY '|'
OPTIONALLY ENCLOSED BY '"' AND '"'
TRAILING NULLCOLS
( 
     v_id                           
    ,v_state_voter_id               
    ,v_last_name                    
    ,v_first_name                   
    ,v_middle_name                  
    ,v_name_suffix                  
    ,v_situs_address                "RTRIM(:v_situs_address)"
    ,v_situs_city
    ,v_situs_state_abbr
    ,v_situs_zip5
    ,v_situs_zip4
    ,v_age                          "NVL(:v_age,18)"
    ,v_gender                      
    ,v_dob                          "NVL(TO_DATE(:v_dob,'MM/DD/YYYY'), TO_DATE('01/01/2002','MM/DD/YYYY'))"
    ,v_race_designation             "NVL(:v_race_designation, 'Unspecified')"     
    ,v_phone_nbr                   
    ,v_email_addr
    ,v_last_registered              "NVL(TO_DATE(:v_last_registered,'MM/DD/YYYY'), TO_DATE('01/01/2002','MM/DD/YYYY'))"
    ,v_orig_registered              "NVL(TO_DATE(:v_orig_registered,'MM/DD/YYYY'), TO_DATE('01/01/2002','MM/DD/YYYY'))"
    ,v_likely_party                 
    ,v_precinct_name
    ,v_county_name
    ,v_city_name
    ,v_township_name
    ,v_last_updated                 SYSDATE
)



