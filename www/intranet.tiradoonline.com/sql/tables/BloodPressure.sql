IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BloodPressure' AND TYPE = 'U')
DROP TABLE BloodPressure;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BloodPressure' AND TYPE = 'U')
	DROP TABLE BloodPressure;
GO

CREATE TABLE BloodPressure
(
	BloodPressureID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	BloodPressureDateTime		 DATETIME  NOT NULL,
	BloodPressureTop		 SMALLINT  NOT NULL,
	BloodPressureBottom		 SMALLINT  NOT NULL,
	BloodPressureComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

