IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'tr_BankingMonthlyExpense_insert_update' AND TYPE = 'P')
	DROP TRIGGER tr_BankingMonthlyExpense_insert_update;
GO

CREATE TRIGGER tr_BankingMonthlyExpense_insert_update
	ON BankingMonthlyExpense
	AFTER INSERT, UPDATE
AS
	
	INSERT INTO BankingMonthlyExpense_updated
		SELECT * FROM inserted;

	
GO
