IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HospitalPosition' AND TYPE = 'U')
DROP TABLE HospitalPosition;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HospitalPosition' AND TYPE = 'U')
	DROP TABLE HospitalPosition;
GO

CREATE TABLE HospitalPosition
(
	HospitalPositionID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HospitalPositionName		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

