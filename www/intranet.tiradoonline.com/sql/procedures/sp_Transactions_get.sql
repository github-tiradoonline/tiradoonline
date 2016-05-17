IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Transactions_get' AND TYPE = 'P')
DROP PROCEDURE sp_Transactions_get;
GO




CREATE PROCEDURE [dbo].[sp_Transactions_get]
	@UserID		INT
AS
	SELECT 
		TransactionID, 
		Description,
		TotalTransactions = (SELECT COUNT(*) FROM Banking WHERE TransactionID = Transactions.TransactionID)
	FROM 
		Transactions 
	WHERE 
		Description IS NOT NULL OR 
		Description <> '' 
	ORDER BY 
		Description;



GO

