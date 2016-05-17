IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'tr_CreditCard_insert_update' AND TYPE = 'TR')
	DROP TRIGGER tr_CreditCard_insert_update;
GO

CREATE TRIGGER tr_CreditCard_insert_update
	ON CreditCard
	AFTER INSERT, UPDATE
AS
	
	INSERT INTO CreditCard_updated
		SELECT * FROM inserted;

	
GO
