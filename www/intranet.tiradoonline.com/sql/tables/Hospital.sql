IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Hospital' AND TYPE = 'U')
DROP TABLE Hospital;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Hospital' AND TYPE = 'U')
	DROP TABLE Hospital;
GO

CREATE TABLE Hospital
(
	HospitalID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HospitalName		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

