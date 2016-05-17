IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'tr_CreditCard_delete' AND TYPE = 'TR')
	DROP TRIGGER tr_CreditCard_delete;
GO

CREATE TRIGGER tr_CreditCard_delete
	ON CreditCard
	AFTER DELETE
AS
	
	INSERT INTO CreditCard_deleted
		SELECT * FROM deleted;

	
GO
