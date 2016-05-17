IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'tr_BankingMonthlyExpense_insert_delete' AND TYPE = 'TR')
	DROP TRIGGER tr_BankingMonthlyExpense_insert_delete;
GO

CREATE TRIGGER tr_BankingMonthlyExpense_insert_delete
	ON BankingMonthlyExpense
	AFTER DELETE
AS
	
	INSERT INTO BankingMonthlyExpense_deleted
		SELECT * FROM deleted;

	
GO
