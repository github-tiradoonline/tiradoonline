IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'EmailTemplates' AND TYPE = 'U')
DROP TABLE EmailTemplates;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'EmailTemplates' AND TYPE = 'U')
	DROP TABLE EmailTemplates;
GO

CREATE TABLE EmailTemplates
(
	EmailTemplateID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	CreateAccountSubject		 VARCHAR(200)  NULL,
	CreateAccountEmail		 VARCHAR(MAX)  NULL,
	ForgotPasswordSubject		 VARCHAR(200)  NULL,
	ForgotPasswordEmail		 VARCHAR(MAX)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

