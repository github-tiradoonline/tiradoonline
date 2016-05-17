IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccountLinked' AND TYPE = 'U')
DROP TABLE BankingAccountLinked;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccountLinked' AND TYPE = 'U')
	DROP TABLE BankingAccountLinked;
GO

CREATE TABLE BankingAccountLinked
(
	BankingAccountLinkedID		IDENTITY (1001,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	Email		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

