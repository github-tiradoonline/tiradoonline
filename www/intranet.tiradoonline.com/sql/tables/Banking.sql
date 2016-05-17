IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Banking' AND TYPE = 'U')
DROP TABLE Banking;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Banking' AND TYPE = 'U')
	DROP TABLE Banking;
GO

CREATE TABLE Banking
(
	BankingID		IDENTITY (1,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	SubBankingAccountID		 INT  NULL,
	TransactionID		 INT  NOT NULL,
	BankingDate		 SMALLDATETIME  NOT NULL,
	Payment		 NUMERIC(8,2)  NOT NULL,
	BankingFile		 BIT DEFAULT ((0)) NOT NULL,
	BankingFileName		 VARCHAR(200)  NULL,
	Comment		 VARCHAR(255)  NULL,
	update_dt		 SMALLDATETIME  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

