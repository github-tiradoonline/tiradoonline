IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CreditCard_old' AND TYPE = 'U')
DROP TABLE CreditCard_old;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CreditCard_old' AND TYPE = 'U')
	DROP TABLE CreditCard_old;
GO

CREATE TABLE CreditCard_old
(
	CCID		IDENTITY (1000,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	CCName		 VARCHAR(20)  NOT NULL,
	CCLimit		 NUMERIC(9,2)  NOT NULL,
	CCExpiration		 SMALLDATETIME  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

