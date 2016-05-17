IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingEmail' AND TYPE = 'U')
DROP TABLE BankingEmail;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingEmail' AND TYPE = 'U')
	DROP TABLE BankingEmail;
GO

CREATE TABLE BankingEmail
(
	BankingEmailID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ToEmail		 VARCHAR(100)  NOT NULL,
	FromEmail		 VARCHAR(100)  NOT NULL,
	Subject		 VARCHAR(100)  NOT NULL,
	BodyText		 TEXT  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

