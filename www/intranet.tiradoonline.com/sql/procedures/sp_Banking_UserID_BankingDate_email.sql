IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_UserID_BankingDate_email' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_UserID_BankingDate_email;
GO



CREATE PROCEDURE [dbo].[sp_Banking_UserID_BankingDate_email]
	@BankingAccountID		INT,
	@BankingDate			SMALLDATETIME
AS

	SELECT TOP 20
		a.BankingID, 
		a.BankingDate, 
		a.Payment, 
		a.Comment, 
		b.Description
	FROM 
		Banking a, Transactions b
	WHERE
		--DATEPART(month, a.BankingDate) = MONTH(@BankingDate) AND 
		--DATEPART(year, a.BankingDate) = YEAR(@BankingDate) AND 
		a.TransactionID = b.TransactionID AND
		a.BankingAccountID = @BankingAccountID
	ORDER BY
		a.BankingDate DESC


GO

