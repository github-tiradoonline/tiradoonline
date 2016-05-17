IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Balance_BalanceID' AND TYPE = 'P')
DROP PROCEDURE sp_Balance_BalanceID;
GO




CREATE PROCEDURE [dbo].[sp_Balance_BalanceID]
	@BalanceID		INT
AS

	SELECT
		BalanceDate, 
		BalanceAccountID,
		SubBalanceAccountID,
		TransactionID, 
		Payment, 
		Comment,
		BankingFile,
		BankingFileName
	FROM 
		Balance 
	WHERE 
		BalanceID = @BalanceID



GO

