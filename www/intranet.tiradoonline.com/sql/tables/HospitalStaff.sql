IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HospitalStaff' AND TYPE = 'U')
DROP TABLE HospitalStaff;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HospitalStaff' AND TYPE = 'U')
	DROP TABLE HospitalStaff;
GO

CREATE TABLE HospitalStaff
(
	HospitalStaffID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HospitalID		 INT  NOT NULL,
	HospitalPositionID		 INT  NOT NULL,
	FirstName		 VARCHAR(50)  NULL,
	LastName		 VARCHAR(50)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

