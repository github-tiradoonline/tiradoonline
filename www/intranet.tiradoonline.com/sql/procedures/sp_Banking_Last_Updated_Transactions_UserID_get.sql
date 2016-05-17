IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_Last_Updated_Transactions_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_Last_Updated_Transactions_UserID_get;
GO



CREATE PROCEDURE sp_Banking_Last_Updated_Transactions_UserID_get
	@UserID			INT
AS


	SELECT TOP 300
		a.create_dt,
		a.update_dt,
		b.BankingAccountName, 
		a.BankingDate, 
		c.Description, 
		a.Payment, 
		a.Comment, 
		a.BankingID, 
		a.BankingFile, 
		a.BankingFileName, 
		a.SubBankingAccountID, 
		SubAccountName = b.BankingAccountName, 
		a.BankingAccountID 
	FROM 
		Banking a, 
		BankingAccount b, 
		Transactions c 
	WHERE 
	  	b.UserID = @UserID 
		AND CONVERT(SMALLDATETIME, a.create_dt) <> CONVERT(SMALLDATETIME, a.update_dt)
		AND a.BankingAccountID = b.BankingAccountID 
		AND a.TransactionID = c.TransactionID 
	ORDER BY
		a.update_dt DESC


GO

