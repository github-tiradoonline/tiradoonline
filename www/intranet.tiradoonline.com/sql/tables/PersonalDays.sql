IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PersonalDays' AND TYPE = 'U')
DROP TABLE PersonalDays;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PersonalDays' AND TYPE = 'U')
	DROP TABLE PersonalDays;
GO

CREATE TABLE PersonalDays
(
	PersonalDayID		IDENTITY (1001,1) INT  NOT NULL,
	CompanyID		 INT  NOT NULL,
	PersonalDate		 SMALLDATETIME  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

