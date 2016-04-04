CREATE SEQUENCE seq_fid
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 3688
  CACHE 1;
ALTER TABLE seq_fid
  OWNER TO tpx_writers;
GRANT ALL ON SEQUENCE seq_fid TO tpx_writers;

CREATE TABLE rootfiles
(
  fid integer NOT NULL DEFAULT nextval('seq_fid'::regclass),
  path text NOT NULL,
  date_added timestamp without time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  start_time timestamp without time zone NOT NULL,
  end_time timestamp without time zone NOT NULL,
  count_frames integer NOT NULL,
  count_entries integer NOT NULL,
  date_checked timestamp without time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  sid integer NOT NULL,
  checksum character varying(40),
  CONSTRAINT pk_fid PRIMARY KEY (fid),
  CONSTRAINT fk_sid FOREIGN KEY (sid)
      REFERENCES sensors (sid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rootfiles
  OWNER TO tpx_writers;
GRANT ALL ON TABLE rootfiles TO tpx_writers;
GRANT SELECT ON TABLE rootfiles TO tpx_readers;

CREATE UNIQUE INDEX idx_path
  ON rootfiles
  USING btree
  (path COLLATE pg_catalog."default");
  