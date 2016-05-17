IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Transactions' AND TYPE = 'U')
DROP TABLE Transactions;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Transactions' AND TYPE = 'U')
	DROP TABLE Transactions;
GO

CREATE TABLE Transactions
(
	TransactionID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	Description		 VARCHAR(1000)  NULL,
	Active		 CHAR(1) DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

