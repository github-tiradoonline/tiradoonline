IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyAddress' AND TYPE = 'U')
DROP TABLE JobCompanyAddress;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompanyAddress' AND TYPE = 'U')
	DROP TABLE JobCompanyAddress;
GO

CREATE TABLE JobCompanyAddress
(
	JobCompanyAddressID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobCompanyAddress1		 VARCHAR(50)  NOT NULL,
	JobCompanyAddress2		 VARCHAR(50)  NULL,
	JobCompanyAddressCity		 VARCHAR(50)  NULL,
	StateID		 INT  NOT NULL,
	JobCompanyAddressZipCode		 VARCHAR(20)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

