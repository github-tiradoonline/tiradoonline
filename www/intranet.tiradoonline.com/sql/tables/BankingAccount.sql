IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccount' AND TYPE = 'U')
DROP TABLE BankingAccount;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'BankingAccount' AND TYPE = 'U')
	DROP TABLE BankingAccount;
GO

CREATE TABLE BankingAccount
(
	BankingAccountID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	BankingAccountName		 VARCHAR(50)  NOT NULL,
	ReceiveEmails		 BIT DEFAULT ((1)) NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

