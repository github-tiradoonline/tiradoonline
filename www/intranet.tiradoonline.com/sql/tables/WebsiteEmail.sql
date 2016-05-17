IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'WebsiteEmail' AND TYPE = 'U')
DROP TABLE WebsiteEmail;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'WebsiteEmail' AND TYPE = 'U')
	DROP TABLE WebsiteEmail;
GO

CREATE TABLE WebsiteEmail
(
	WebsiteEmailID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	WebsiteFromEmail		 VARCHAR(50)  NOT NULL,
	WebsiteEmailBodyText		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

