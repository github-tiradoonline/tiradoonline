--******************************
--  AA_MeetingBorough
--******************************


IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_ID('AA_MeetingBorough') IS NOT NULL)
	DROP TABLE AA_MeetingBorough;
GO

CREATE TABLE AA_MeetingBorough
(
	AA_MeetingBoroughID		INT IDENTITY(1001, 1) NOT NULL,
	AA_MeetingBoroughName		VARCHAR(20) NOT NULL,
	create_dt			DATETIME DEFAULT GETDATE() NOT NULL
);

GO

ALTER TABLE AA_MeetingBorough ADD CONSTRAINT PK_AA_MeetingBorough PRIMARY KEY (AA_MeetingBoroughID);
GO

INSERT INTO AA_MeetingBorough (AA_MeetingBoroughName) VALUES ('Bronx');
INSERT INTO AA_MeetingBorough (AA_MeetingBoroughName) VALUES ('Manhattan');
INSERT INTO AA_MeetingBorough (AA_MeetingBoroughName) VALUES ('Queens');
INSERT INTO AA_MeetingBorough (AA_MeetingBoroughName) VALUES ('Brooklyn');
GO


--******************************
--  AA_MeetingType
--******************************


IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_ID('AA_MeetingType') IS NOT NULL)
	DROP TABLE AA_MeetingType;
GO

CREATE TABLE AA_MeetingType
(
	AA_MeetingTypeID		INT IDENTITY(1001, 1) NOT NULL,
	AA_MeetingTypeAbbr		VARCHAR(2) NOT NULL,
	AA_MeetingTypeName		VARCHAR(100) NOT NULL,
	create_dt			DATETIME DEFAULT GETDATE() NOT NULL
);

GO

ALTER TABLE AA_MeetingType ADD CONSTRAINT PK_AA_MeetingType PRIMARY KEY (AA_MeetingTypeID);
GO

INSERT INTO AA_MeetingType (AA_MeetingTypeAbbr, AA_MeetingTypeName) VALUES ('O', 'Opening Meeting');
INSERT INTO AA_MeetingType (AA_MeetingTypeAbbr, AA_MeetingTypeName) VALUES ('OD', 'Open Discussion Meeting');
INSERT INTO AA_MeetingType (AA_MeetingTypeAbbr, AA_MeetingTypeName) VALUES ('B', 'Beginners'' Meeting');
INSERT INTO AA_MeetingType (AA_MeetingTypeAbbr, AA_MeetingTypeName) VALUES ('BB', 'Big Book Meeting');
INSERT INTO AA_MeetingType (AA_MeetingTypeAbbr, AA_MeetingTypeName) VALUES ('C', 'Closed Discussion');
INSERT INTO AA_MeetingType (AA_MeetingTypeAbbr, AA_MeetingTypeName) VALUES ('S', 'Step Meeting');
INSERT INTO AA_MeetingType (AA_MeetingTypeAbbr, AA_MeetingTypeName) VALUES ('T', 'Traditional Meeting');



--******************************
--  AA_MeetingTimeType
--******************************


IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_ID('AA_MeetingTimeType') IS NOT NULL)
	DROP TABLE AA_MeetingTimeType;
GO

CREATE TABLE AA_MeetingTimeType
(
	AA_MeetingTimeTypeID		INT IDENTITY(1001, 1) NOT NULL,
	AA_MeetingTimeTypeAbbr		VARCHAR(2) NOT NULL,
	AA_MeetingTimeTypeName		VARCHAR(100) NOT NULL,
	create_dt			DATETIME DEFAULT GETDATE() NOT NULL
);

GO

ALTER TABLE AA_MeetingTimeType ADD CONSTRAINT PK_AA_MeetingTimeType PRIMARY KEY (AA_MeetingTimeTypeID);
GO

INSERT INTO AA_MeetingTimeType (AA_MeetingTimeTypeAbbr, AA_MeetingTimeTypeName) VALUES ('A', 'Morning');
INSERT INTO AA_MeetingTimeType (AA_MeetingTimeTypeAbbr, AA_MeetingTimeTypeName) VALUES ('D', 'ASL Interpreted');
INSERT INTO AA_MeetingTimeType (AA_MeetingTimeTypeAbbr, AA_MeetingTimeTypeName) VALUES ('M', 'Midnight');
INSERT INTO AA_MeetingTimeType (AA_MeetingTimeTypeAbbr, AA_MeetingTimeTypeName) VALUES ('N', 'Noon');
INSERT INTO AA_MeetingTimeType (AA_MeetingTimeTypeAbbr, AA_MeetingTimeTypeName) VALUES ('SP', 'Spanish Speaking');
INSERT INTO AA_MeetingTimeType (AA_MeetingTimeTypeAbbr, AA_MeetingTimeTypeName) VALUES ('WC', 'Wheelchair Accessible');
GO




--******************************
--  AA_MeetingDayOfWeek
--******************************


IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_ID('AA_MeetingDayOfWeek') IS NOT NULL)
	DROP TABLE AA_MeetingDayOfWeek;
GO

CREATE TABLE AA_MeetingDayOfWeek
(
	AA_MeetingDayOfWeekID		INT IDENTITY(1001, 1) NOT NULL,
	AA_MeetingDayOfWeekName		VARCHAR(100) NOT NULL,
	create_dt			DATETIME DEFAULT GETDATE() NOT NULL
);

GO

ALTER TABLE AA_MeetingDayOfWeek ADD CONSTRAINT PK_AA_MeetingDayOfWeek PRIMARY KEY (AA_MeetingDayOfWeekID);
GO

INSERT INTO AA_MeetingDayOfWeek (AA_MeetingDayOfWeekName) VALUES ('Sunday');
INSERT INTO AA_MeetingDayOfWeek (AA_MeetingDayOfWeekName) VALUES ('Monday');
INSERT INTO AA_MeetingDayOfWeek (AA_MeetingDayOfWeekName) VALUES ('Tuesday');
INSERT INTO AA_MeetingDayOfWeek (AA_MeetingDayOfWeekName) VALUES ('Wednesday');
INSERT INTO AA_MeetingDayOfWeek (AA_MeetingDayOfWeekName) VALUES ('Thursday');
INSERT INTO AA_MeetingDayOfWeek (AA_MeetingDayOfWeekName) VALUES ('Friday');
INSERT INTO AA_MeetingDayOfWeek (AA_MeetingDayOfWeekName) VALUES ('Saturday');



--******************************
--  AA_MeetingLocation
--******************************


IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_ID('AA_MeetingLocation') IS NOT NULL)
	DROP TABLE AA_MeetingLocation;
GO

CREATE TABLE AA_MeetingLocation
(
	AA_MeetingLocationID		INT IDENTITY(1001, 1) NOT NULL,
	AA_MeetingBoroughID		INT NOT NULL,
	AA_Zone				TINYINT NOT NULL,
	AA_MeetingName			VARCHAR(100) NOT NULL,
	AA_Address1			VARCHAR(100) NOT NULL,
	AA_Address2			VARCHAR(100) NULL,
	AA_Address3			VARCHAR(100) NULL,
	AA_ZipCode			VARCHAR(10) NOT NULL,
	AA_Comments			VARCHAR(MAX) NULL,
	create_dt			DATETIME DEFAULT GETDATE() NOT NULL
);

GO

ALTER TABLE AA_MeetingLocation ADD CONSTRAINT PK_AA_MeetingLocation PRIMARY KEY (AA_MeetingLocationID);
GO



--******************************
--  sp_AA_MeetingLocation_insert
--******************************


IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_ID('sp_AA_MeetingLocation_insert') IS NOT NULL)
	DROP PROCEDURE sp_AA_MeetingLocation_insert;
GO

CREATE PROCEDURE sp_AA_MeetingLocation_insert
	@AA_MeetingBoroughID		INT,
	@AA_Zone			TINYINT,
	@AA_MeetingName			VARCHAR(100),
	@AA_Address1			VARCHAR(100),
	@AA_Address2			VARCHAR(100),
	@AA_Address3			VARCHAR(100),
	@AA_ZipCode			VARCHAR(10),
	@AA_Comments			VARCHAR(MAX)
AS

	INSERT INTO AA_MeetingLocation
		(AA_MeetingBoroughID, AA_Zone, AA_MeetingName, AA_Address1, AA_Address2, AA_Address3, AA_ZipCode, AA_Comments)
	VALUES
		(@AA_MeetingBoroughID, @AA_Zone, @AA_MeetingName, @AA_Address1, @AA_Address2, @AA_Address3, @AA_ZipCode, @AA_Comments);

	SELECT @@IDENTITY;
GO



select * from AA_MeetingBorough
select * from AA_MeetingType
select * from AA_MeetingTimeType
select * from AA_MeetingDayOfWeek
select * from AA_MeetingLocation

