CREATE SEQUENCE seq_frid
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 178994830
  CACHE 1;
ALTER TABLE seq_frid
  OWNER TO tpx_writers;

CREATE TABLE frames
(
  start_time timestamp without time zone NOT NULL,
  fid integer NOT NULL,
  dsc_entry integer NOT NULL,
  clstr_first_entry integer,
  clstr1_count integer NOT NULL,
  clstr2_count integer NOT NULL,
  clstr3_count integer NOT NULL,
  clstr4_count integer NOT NULL,
  clstr5_count integer NOT NULL,
  clstr6_count integer NOT NULL,
  sid integer NOT NULL,
  acquisition_time interval NOT NULL,
  occupancy integer,
  frid bigint NOT NULL DEFAULT nextval('seq_frid'::regclass),
  CONSTRAINT pk_frid PRIMARY KEY (frid),
  CONSTRAINT fk_fid FOREIGN KEY (fid)
      REFERENCES rootfiles (fid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT fk_sid FOREIGN KEY (sid)
      REFERENCES sensors (sid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE frames
  OWNER TO tpx_writers;
GRANT ALL ON TABLE frames TO tpx_writers;
GRANT SELECT ON TABLE frames TO tpx_readers;

CREATE INDEX fki_fid
  ON frames
  USING btree
  (fid);

CREATE INDEX fki_sid
  ON frames
  USING btree
  (sid);

CREATE UNIQUE INDEX id_start_time_fid
  ON frames
  USING btree
  (start_time, fid);

CREATE UNIQUE INDEX idx_fid_dsc_entry_start_time
  ON frames
  USING btree
  (fid, dsc_entry, start_time);

CREATE INDEX idx_start_time
  ON frames
  USING btree
  (start_time);

CREATE UNIQUE INDEX idx_start_time_sid
  ON frames
  USING btree
  (start_time, sid);
