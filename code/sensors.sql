CREATE SEQUENCE seq_sid
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 15
  CACHE 1;
ALTER TABLE seq_sid
  OWNER TO tpx_writers;
GRANT ALL ON SEQUENCE seq_sid TO tpx_writers;

CREATE TABLE sensors
(
  sid integer NOT NULL DEFAULT nextval('seq_sid'::regclass),
  name text,
  calibration_layer1 double precision,
  calibration_layer2 double precision,
  CONSTRAINT pk_sid PRIMARY KEY (sid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sensors
  OWNER TO tpx_writers;
GRANT ALL ON TABLE sensors TO tpx_writers;
GRANT SELECT ON TABLE sensors TO tpx_readers;
