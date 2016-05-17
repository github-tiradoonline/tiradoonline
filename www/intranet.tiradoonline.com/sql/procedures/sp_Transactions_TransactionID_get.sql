IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Transactions_TransactionID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Transactions_TransactionID_get;
GO




CREATE PROCEDURE [dbo].[sp_Transactions_TransactionID_get]
	@TransactionID		INT	
AS
	SELECT 
		TransactionID, 
		Description,
		TotalTransactions = (SELECT COUNT(*) FROM Banking WHERE TransactionID = Transactions.TransactionID)
	FROM 
		Transactions
	WHERE
		TransactionID = @TransactionID; 



GO

