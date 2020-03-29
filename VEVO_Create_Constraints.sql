/*
|| Script:	VEVO_Create_Constraints.sql
|| Purpose:	1.) Builds PK and FK constraints and indexes
||					2.) Builds indexes
||          3.) Gathers schema-wide statistics
|| Author:	Jim Czuprynski
|| Version: 2.0
*/

/*
|| Indexes:
*/

ALTER TABLE vevo.t_staff
    ADD CONSTRAINT staff_pk 
    PRIMARY KEY (st_sk)
    USING INDEX ( 
        CREATE INDEX vevo.staff_pk_idx
            ON vevo.t_staff (st_sk)
            TABLESPACE vevo_idx
        );

ALTER TABLE vevo.t_campaign_org
    ADD CONSTRAINT co_pk 
    PRIMARY KEY (co_st_sk, co_hier_sk, co_beg_dt)
    USING INDEX ( 
        CREATE INDEX vevo.co_pk_idx
            ON vevo.t_campaign_org (co_st_sk, co_hier_sk, co_beg_dt)
            TABLESPACE vevo_idx
        );

ALTER TABLE vevo.t_voters
    ADD CONSTRAINT voters_pk 
    PRIMARY KEY (v_id)
    USING INDEX ( 
        CREATE INDEX vevo.voters_pk_idx
            ON vevo.t_voters (v_id)
            TABLESPACE vevo_idx
        );

ALTER TABLE vevo.t_voting_results
    ADD CONSTRAINT vr_pk 
    PRIMARY KEY (vr_v_id, vr_election_abbr)
    USING INDEX ( 
        CREATE INDEX vevo.vr_pk_idx
            ON vevo.t_voting_results (vr_v_id, vr_election_abbr)
            TABLESPACE vevo_idx
        );

ALTER TABLE vevo.t_canvassing
    ADD CONSTRAINT cv_pk 
    PRIMARY KEY (cv_v_id, cv_st_sk, cv_date)
    USING INDEX ( 
        CREATE INDEX vevo.cv_pk_idx
            ON vevo.t_canvassing (cv_v_id, cv_st_sk, cv_date)
            TABLESPACE vevo_idx
        );

/*
|| FK Constraints:
*/

ALTER TABLE vevo.t_campaign_org
    ADD CONSTRAINT co_st_fk 
    FOREIGN KEY (co_st_sk)
    REFERENCES vevo.t_staff (st_sk);

ALTER TABLE vevo.t_campaign_org
    ADD CONSTRAINT co_hier_fk 
    FOREIGN KEY (co_hier_sk)
    REFERENCES vevo.t_staff (st_sk);

ALTER TABLE vevo.t_voting_results
    ADD CONSTRAINT vr_v_vr_fk 
    FOREIGN KEY (vr_v_id)
    REFERENCES vevo.t_voters (v_id);

ALTER TABLE vevo.t_canvassing
    ADD CONSTRAINT cv_v_fk 
    FOREIGN KEY (cv_v_id)
    REFERENCES vevo.t_voters (v_id);

ALTER TABLE vevo.t_canvassing
    ADD CONSTRAINT cv_st_fk 
    FOREIGN KEY (cv_st_sk)
    REFERENCES vevo.t_staff (st_sk);

-----
-- Gather schema-wide statistics
-----
BEGIN
    DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'VEVO');
END;
/
