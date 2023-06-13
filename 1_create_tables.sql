---create VIDEOSTART_RAW to load the raw file
CREATE TABLE "VIDEOSTART_RAW"
("DATETIME" VARCHAR2(30 BYTE),
 "VIDEOTITLE" VARCHAR2(200 BYTE),
 "EVENTS" VARCHAR2(150 BYTE)
);

-- create VIDEOSTART_DLT to store the data after data transformation
CREATE TABLE "VIDEOSTART_DLT"
( " DATETIME" TIMESTAMP(6) NOT NULL ENABLE,
 "PLATFORM" VARCHAR2(200 BYTE) NOT NULL ENABLE,
 "SITE" VARCHAR2(200 BYTE) NOT NULL ENABLE,
 "VIDEO" VARCHAR2(200 BYTE) NOT NULL ENABLE
);

---create FACTVIDEOSTART to store the transaction data
CREATE TABLE "FACTVIDEOSTART"
("DATETIME_SKEY" VARCHAR2(12 BYTE) NOT NULL ENABLE,
"PLATFORM_SKEY" NUMBER(38,0) NOT NULL ENABLE,
"SITE_SKEY" NUMBER(38,0) NOT NULL ENABLE,
"VIDEO_SKEY" NUMBER(38,0) NOT NULL ENABLE,
"DB_INSERT_TIMESTAMP" TIMESTAMP(6) NOT NULL ENABLE
);

-- create DIMDATE_DLT to store DATETIME data from raw file
CREATE TABLE "DIMDATE_DLT"
("DATETIME" VARCHAR2(12 BYTE) NOT NULL ENABLE,
CONSTRAINT dimdate_dlt_pk PRIMARY KEY(DATETIME)
)

--create DIMPLATFORM_DLT to store PLATFORM data from raw file
CREATE TABLE "DIMPLATFORM_DLT"
("DATETIME" VARCHAR2(12 BYTE) NOT NULL ENABLE,
CONSTRAINT dimdate_dlt_pk PRIMARY KEY(DATETIME)
);

--create DIMPLATFORM_DLT to store PLATFORM data from raw file
CREATE TABLE "DIMPLATFORM_DLT"
("PLATFORM" VARCHAR2(200 BYTE) NOT NULL ENABLE,
CONSTRAINT dimplatform_dlt_pk PRIMARY KEY(PLATFORM)
);

--create  DIMSITE_DLT to store SITE data from raw file
CREATE TABLE "DIMSITE_DLT"
("SITE" VARCHAR2(200 BYTE) NOT NULL ENABLE,
CONSTRAINT dimsite_dlt_pk PRIMARY KEY (SITE)
);

-- create DIMVIDEO_DLT to store VIDEO data from raw file
CREATE TABLE "DIMVIDEO_DLT"
("VIDEO" VARCHAR2(200 BYTE) NOT NULL ENABLE,
CONSTRAINT dimvideo_dlt_pk PRIMARY KEY(VIDEO)
);

-- create dimension table DIMDATE
CREATE TABLE "DIMDATE"
("DATETIME_SKEY" VARCHAR2(12 BYTE) NOT NULL ENABLE,
CONSTRAINT dimdate_pk PRIMARY KEY(DATETIME_SKEY)
);

-- create dimension table DIMPLATFORM
CREATE TABLE "DIMPLATFORM"
("PLATFORM_SKEY" NUMBER NOT NULL ENABLE,
"PLATFORM" VARCHAR2(200 BYTE) NOT NULL ENABLE,
CONSTRAINT dimplatform_pk PRIMARY KEY(PLATFORM_SKEY)
);

-- initially insert one record
INSERT INTO DIMPLATFORM VALUES(-1, 'Unknown');

-- create dimension table DIMSITE
CREATE TABLE "DIMSITE"
("SITE_SKEY" NUMBER NOT NULL ENABLE,
"SITE" VARCHAR2(200 BYTE) NOT NULL ENABLE,
CONSTRAINT dimsite_pk PRIMARY KEY(SITE_SKEY)
);

--initially insert one record
INSERT INTO DIMSITE VALUES(-1,'Unknown');

-- create dimension table DIMVIDEO
CREATE TABLE "DIMVIDEO"
("VIDEO_SKEY" NUMBER NOT NULL ENABLE,
"VIDEO" VARCHAR2(200 BYTE) NOT NULL ENABLE,
CONSTRAINT dimvideo_pk PRIMARY KEY(VIDEO_SKEY)
);

-- create sequence for DIMPLATFORM
CREATE SEQUENCE "DIMPLATFORM_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE;
-- create trigger to automatically generate PLATFORM_SKEY
create or replace TRIGGER "DIMPLATFORM_TRT"
before insert on DIMPLATFORM
for each row
begin
select DIMPLATFORM_SEQ.nextval into :new.PLATFORM_SKEY from dual;
end;

-- create sequence for DIMSITE
CREATE SEQUENCE "DIMSITE_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE;
-- create trigger to automatically generate SITE_SKEY
create or replace TRIGGER "DIMSITE_TRI"
before insert on DIMSITE
for each row
begin
select DIMSITE_SEQ.nextval into: new.SITE_SKEY from dual;
end;

-- create sequence for DIMVIDEO
CREATE SEQUENCE "DIMVIDEO_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER NOCYCLE;
-- create trigger to automatically generate VIDEO_SKEY
create or replace TRIGGER "DIMVIDEO_TRI"
before insert on DIMVIDEO
for each row
begin
select DIMVIDEO_SEQ.nextval into:new.VIDEO_SKEY from dual;
end;

-- create fact table FACTVIDEOSTART
CREATE TABLE "FACTVIDEOSTART"
("DATETIME_SKEY" TIMESTAMP (6) NOT NULL ENABLE,
"PLATFORM_SKEY" VARCHAR2(200 BYTE) NOT NULL ENABLE,
"SITE_SKEY" VARCHAR2(200 BYTE) NOT NULL ENABLE,
"VIDEO_SKEY" VARCHAR2(200 BYTE) NOT NULL ENABLE 
);