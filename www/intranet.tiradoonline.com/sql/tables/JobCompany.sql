IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompany' AND TYPE = 'U')
DROP TABLE JobCompany;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCompany' AND TYPE = 'U')
	DROP TABLE JobCompany;
GO

CREATE TABLE JobCompany
(
	JobCompanyID		IDENTITY (1001,1) INT  NOT NULL,
	JobIDOld		 INT  NULL,
	UserID		 INT  NOT NULL,
	JobCompanyName		 VARCHAR(50)  NOT NULL,
	JobCompanyWebsite		 VARCHAR(100)  NULL,
	JobCompanyLinkedIn		 VARCHAR(500)  NULL,
	JobCompanyTwitter		 VARCHAR(500)  NULL,
	JobCompanyFacebook		 VARCHAR(500)  NULL,
	JobCompanyGooglePlus		 VARCHAR(500)  NULL,
	JobCompanyYouTube		 VARCHAR(500)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

