IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_BankingID' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_BankingID;
GO




CREATE PROCEDURE [dbo].[sp_Banking_BankingID]
	@BankingID		INT
AS

	SELECT
		BankingDate, 
		BankingAccountID,
		SubBankingAccountID,
		TransactionID, 
		Payment, 
		Comment,
		BankingFile,
		BankingFileName
	FROM 
		Banking 
	WHERE 
		BankingID = @BankingID



GO

