IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetCompany' AND TYPE = 'U')
DROP TABLE TimesheetCompany;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetCompany' AND TYPE = 'U')
	DROP TABLE TimesheetCompany;
GO

CREATE TABLE TimesheetCompany
(
	TimeSheetCompanyID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TimesheetCompanyName		 VARCHAR(100)  NOT NULL,
	TimesheetCompanyAddress1		 VARCHAR(100)  NULL,
	TimesheetCompanyAddress2		 VARCHAR(100)  NULL,
	TimesheetCompanyCity		 VARCHAR(100)  NULL,
	TimesheetCompanyStateID		 INT  NULL,
	TimesheetCompanyZipCode		 VARCHAR(20)  NULL,
	TimesheetCompanyPhone		 VARCHAR(50)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

