IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Transactions_UserID_Totals' AND TYPE = 'P')
	DROP PROCEDURE sp_Transactions_UserID_Totals;
GO


CREATE PROCEDURE sp_Transactions_UserID_Totals
	@UserID			INT
AS
	
	SELECT 
		TransactionName = Description,
		TransactionTotal = (SELECT SUM(Payment) FROM Banking WHERE TransactionID = Transactions.TransactionID)
	FROM 
		Transactions
	WHERE 
		UserID = @UserID
	ORDER BY 
		TransactionName
GO

EXEC sp_Transactions_UserID_Totals 1001
