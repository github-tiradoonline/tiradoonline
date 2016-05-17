IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Doctor' AND TYPE = 'U')
DROP TABLE Doctor;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Doctor' AND TYPE = 'U')
	DROP TABLE Doctor;
GO

CREATE TABLE Doctor
(
	DoctorID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	FirstName		 VARCHAR(20)  NULL,
	LastName		 VARCHAR(50)  NOT NULL,
	TelephoneNumber		 VARCHAR(50)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

