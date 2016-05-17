IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'CreditCardPayment' AND TYPE = 'U')
	DROP TABLE CreditCardPayment;
GO

CREATE TABLE CreditCardPayment
(
	CreditCardPaymentID		INT IDENTITY (1001,1) NOT NULL,
	CreditCardID			INT NOT NULL FOREIGN KEY REFERENCES CreditCard(CreditCardID),
	CreditCardPaymentDate		DATETIME NOT NULL,
	CreditCardPaymentAmount		NUMERIC(9, 2) NOT NULL,
	CreditCardPaymentComment	VARCHAR(5000),
	create_dt		 	DATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE CreditCardPayment ADD CONSTRAINT PK_CreditCardPayment_CreditCardPaymentID PRIMARY KEY NONCLUSTERED (CreditCardPaymentID);
GO
