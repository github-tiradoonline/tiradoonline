IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE OBJECT_NAME(ID) = 'BankingMonthlyExpense')
	DROP TABLE BankingMonthlyExpense;
GO

CREATE TABLE BankingMonthlyExpense
(
	BankingMonthlyExpenseID			INT IDENTITY(1001, 1) NOT NULL,
	UserID					INT NOT NULL,
	BankingMonthlyExpenseName		VARCHAR(100) NOT NULL,
	BankingMonthlyExpenseAmount		NUMERIC(9, 2) NOT NULL,
	BankingMonthlyExpenseBillDate		TINYINT NOT NULL,
	create_dt				DATETIME NOT NULL DEFAULT GETDATE() 
);
GO

SELECT * FROM BankingMonthlyExpense;