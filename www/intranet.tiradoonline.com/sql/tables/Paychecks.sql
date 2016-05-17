IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Paychecks' AND TYPE = 'U')
DROP TABLE Paychecks;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Paychecks' AND TYPE = 'U')
	DROP TABLE Paychecks;
GO

CREATE TABLE Paychecks
(
	PaycheckID		IDENTITY (1001,1) INT  NOT NULL,
	TimesheetCompanyID		 INT  NULL,
	PaymentDate		 DATETIME DEFAULT (getdate()) NOT NULL,
	HourlyRate		 NUMERIC(6,2) DEFAULT ((0)) NOT NULL,
	Gross		 NUMERIC(7,2) DEFAULT ((0)) NOT NULL,
	Federal		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	SocialSecurity		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	Medicare		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	NY_Withholding		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	NY_Disability		 NUMERIC(7,2) DEFAULT ((0)) NULL,
	NY_City		 NUMERIC(7,2) DEFAULT ((0)) NULL

);
GO




GO

GO

