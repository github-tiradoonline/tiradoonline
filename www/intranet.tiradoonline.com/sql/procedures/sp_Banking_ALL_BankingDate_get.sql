IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_ALL_BankingDate_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Banking_ALL_BankingDate_get;
GO

CREATE PROCEDURE sp_Banking_ALL_BankingDate_get
	@UserID			INT,
	@BankingDate		SMALLDATETIME
AS

	SELECT
		a.BankingDate,
		a.BankingID,
		b.BankingAccountID,
		a.SubBankingAccountID,	
		b.BankingAccountName,
		SubAccountName = CASE 
					WHEN SubBankingAccountID IS NOT NULL THEN
						(SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = a.SubBankingAccountID)
					ELSE
						NULL
				END,
		a.Payment,
		a.Comment,
		c.Description,
		a.BankingFile,
		a.BankingFileName
	FROM 
		Banking a, 
		BankingAccount b,
		Transactions c
	WHERE
		a.BankingAccountID = b.BankingAccountID
		AND a.TransactionID = c.TransactionID
		AND b.UserID = @UserID
		AND DATEPART(month, a.BankingDate) = MONTH(@BankingDate)
		AND DATEPART(year, a.BankingDate) = YEAR(@BankingDate)
	ORDER BY
		a.BankingDate,
		a.create_dt;



GO
EXEC sp_Banking_ALL_BankingDate_get 1001, '5/1/15'