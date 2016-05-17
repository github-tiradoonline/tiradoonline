IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccountEmail' AND TYPE = 'U')
DROP TABLE BankingAccountEmail;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccountEmail' AND TYPE = 'U')
	DROP TABLE BankingAccountEmail;
GO

CREATE TABLE BankingAccountEmail
(
	BankingAccountEmailID		IDENTITY (1001,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	BankingAccountEmail		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME  NOT NULL

);
GO




GO


GO

