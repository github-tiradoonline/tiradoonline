IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Transactions_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Transactions_UserID_get;
GO




CREATE PROCEDURE [dbo].[sp_Transactions_UserID_get]
	@UserID		INT
AS
	SELECT 
		TransactionID, 
		Description,
		TotalTransactions = (SELECT COUNT(*) FROM Transactions 	WHERE UserID = @UserID AND (Description IS NOT NULL OR Description <> ''))

	FROM 
		Transactions 
	WHERE 
		UserID = @UserID AND
		(Description IS NOT NULL OR 
		Description <> '')
	ORDER BY 
		Description;



GO

