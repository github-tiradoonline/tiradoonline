IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_BankingAccountID_TransactionID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_BankingAccountID_TransactionID_get;
GO


CREATE PROCEDURE [dbo].[sp_Banking_BankingAccountID_TransactionID_get]
	@BankingAccountID		INT,
	@TransactionID			INT
AS

	SELECT
		a.BankingID, 
		a.BankingDate, 
		a.Payment, 
		a.Comment, 
		b.Description
	FROM 
		Banking a, 
		Transactions b
	WHERE
		b.TransactionID = @TransactionID AND
		a.TransactionID = b.TransactionID AND
		a.BankingAccountID = @BankingAccountID
	ORDER BY
		a.BankingDate;


GO

