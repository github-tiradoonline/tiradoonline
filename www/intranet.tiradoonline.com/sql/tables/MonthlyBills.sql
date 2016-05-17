IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MonthlyBills' AND TYPE = 'U')
DROP TABLE MonthlyBills;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MonthlyBills' AND TYPE = 'U')
	DROP TABLE MonthlyBills;
GO

CREATE TABLE MonthlyBills
(
	MonthlyBillID		IDENTITY (1001,1) INT  NOT NULL,
	BankingAccountID		 INT  NOT NULL,
	MonthlyBillStartDate		 SMALLDATETIME  NOT NULL,
	MonthlyBillDate		 SMALLDATETIME  NOT NULL,
	MonthlyBillDesc		 VARCHAR(100)  NOT NULL,
	MonthlyBillAmount		 NUMERIC(9,2)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

