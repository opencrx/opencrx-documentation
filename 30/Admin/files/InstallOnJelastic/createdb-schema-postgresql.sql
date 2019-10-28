-- Table: oocke1_segment

-- DROP TABLE oocke1_segment;

CREATE TABLE oocke1_segment
(
  object_id character varying(256) NOT NULL,
  description character varying(256),
  "p$$parent" character varying(256),
  dtype character varying(256) NOT NULL,
  access_level_browse smallint,
  access_level_delete smallint,
  access_level_update smallint,
  owner_ integer NOT NULL DEFAULT (-1),
  CONSTRAINT oocke1_segment_pkey PRIMARY KEY (object_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oocke1_segment
  OWNER TO postgres;


-- Table: oocke1_segment_

-- DROP TABLE oocke1_segment_;

CREATE TABLE oocke1_segment_
(
  object_id character varying(256) NOT NULL,
  idx integer NOT NULL,
  dtype character varying(256) NOT NULL,
  owner character varying(256),
  CONSTRAINT oocke1_segment__pkey PRIMARY KEY (object_id, idx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oocke1_segment_
  OWNER TO postgres;


-- Table: oomse2_principal

-- DROP TABLE oomse2_principal;

CREATE TABLE oomse2_principal
(
  object_id character varying(256) NOT NULL,
  auth_credential_ integer NOT NULL DEFAULT (-1),
  created_at timestamp with time zone,
  created_by_ integer NOT NULL DEFAULT (-1),
  credential character varying(256),
  description character varying(256),
  disabled boolean,
  is_member_of_ integer NOT NULL DEFAULT (-1),
  modified_by_ integer NOT NULL DEFAULT (-1),
  name character varying(256),
  "p$$parent" character varying(256),
  subject character varying(256),
  modified_at timestamp with time zone NOT NULL,
  dtype character varying(256) NOT NULL,
  last_login_at timestamp with time zone,
  granted_role_ integer NOT NULL DEFAULT (-1),
  is_final boolean,
  CONSTRAINT oocse1_principal_pkey PRIMARY KEY (object_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_principal
  OWNER TO postgres;

-- Index: i_oomse2_principal

-- DROP INDEX i_oomse2_principal;

CREATE INDEX i_oomse2_principal
  ON oomse2_principal
  USING btree
  (name COLLATE pg_catalog."default");

-- Table: oomse2_principal_

-- DROP TABLE oomse2_principal_;

CREATE TABLE oomse2_principal_
(
  object_id character varying(256) NOT NULL,
  idx integer NOT NULL,
  auth_credential character varying(256),
  created_by character varying(256),
  is_member_of character varying(256),
  modified_by character varying(256),
  dtype character varying(256) NOT NULL,
  granted_role character varying(256),
  CONSTRAINT oocse1_principal__pkey PRIMARY KEY (object_id, idx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_principal_
  OWNER TO postgres;

-- Table: oomse2_realm

-- DROP TABLE oomse2_realm;

CREATE TABLE oomse2_realm
(
  object_id character varying(256) NOT NULL,
  created_at timestamp with time zone,
  created_by_ integer NOT NULL DEFAULT (-1),
  description character varying(256),
  modified_by_ integer NOT NULL DEFAULT (-1),
  name character varying(256),
  "p$$parent" character varying(256),
  modified_at timestamp with time zone NOT NULL,
  dtype character varying(256) NOT NULL,
  CONSTRAINT oocse1_realm_pkey PRIMARY KEY (object_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_realm
  OWNER TO postgres;

-- Index: oomse2_realm_name

-- DROP INDEX oomse2_realm_name;

CREATE INDEX oomse2_realm_name
  ON oomse2_realm
  USING btree
  (name COLLATE pg_catalog."default");

-- Table: oomse2_realm_

-- DROP TABLE oomse2_realm_;

CREATE TABLE oomse2_realm_
(
  object_id character varying(256) NOT NULL,
  idx integer NOT NULL,
  created_by character varying(256),
  modified_by character varying(256),
  dtype character varying(256) NOT NULL,
  CONSTRAINT oocse1_realm__pkey PRIMARY KEY (object_id, idx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_realm_
  OWNER TO postgres;

-- Table: oomse2_segment

-- DROP TABLE oomse2_segment;

CREATE TABLE oomse2_segment
(
  object_id character varying(256) NOT NULL,
  description character varying(256),
  "p$$parent" character varying(256),
  dtype character varying(256) NOT NULL,
  CONSTRAINT oocse1_segment_pkey PRIMARY KEY (object_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_segment
  OWNER TO postgres;

-- Table: oomse2_segment_

-- DROP TABLE oomse2_segment_;

CREATE TABLE oomse2_segment_
(
  object_id character varying(256) NOT NULL,
  idx integer NOT NULL,
  dtype character varying(256) NOT NULL,
  CONSTRAINT oocse1_segment__pkey PRIMARY KEY (object_id, idx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_segment_
  OWNER TO postgres;

-- Table: oomse2_subject

-- DROP TABLE oomse2_subject;

CREATE TABLE oomse2_subject
(
  object_id character varying(256) NOT NULL,
  created_at timestamp with time zone,
  created_by_ integer NOT NULL DEFAULT (-1),
  description character varying(256),
  modified_by_ integer NOT NULL DEFAULT (-1),
  "p$$parent" character varying(256),
  modified_at timestamp with time zone NOT NULL,
  dtype character varying(256) NOT NULL,
  CONSTRAINT oocse1_subject_pkey PRIMARY KEY (object_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_subject
  OWNER TO postgres;

-- Table: oomse2_subject_

-- DROP TABLE oomse2_subject_;

CREATE TABLE oomse2_subject_
(
  object_id character varying(256) NOT NULL,
  idx integer NOT NULL,
  created_by character varying(256),
  modified_by character varying(256),
  dtype character varying(256) NOT NULL,
  CONSTRAINT oocse1_subject__pkey PRIMARY KEY (object_id, idx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE oomse2_subject_
  OWNER TO postgres;

