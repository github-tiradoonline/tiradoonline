IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CreditCard' AND TYPE = 'U')
DROP TABLE CreditCard;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CreditCard' AND TYPE = 'U')
	DROP TABLE CreditCard;
GO

CREATE TABLE CreditCard
(
	CreditCardID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	CreditCardName		 VARCHAR(50)  NOT NULL,
	CreditLimit		 NUMERIC(9,2)  NOT NULL,
	MinimumPayment		 NUMERIC(9,2)  NULL,
	CreditAvailable		 NUMERIC(9,2)  NULL,
	ClosingDate		 TINYINT  NULL,
	DueDate		 TINYINT  NULL,
	Percentage		 NUMERIC(9,2)  NULL,
	Payments		 NUMERIC(9,2)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

