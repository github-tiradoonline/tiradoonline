IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_SubAccounts_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_SubAccounts_get;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_SubAccounts_get]
	@BankingAccountID		INT
AS

	--SET @BankingAccountID = 1049;

	SELECT 
		DISTINCT a.BankingAccountName,
		SubBankingTotal = SUM(Payment)
	FROM 
		BankingAccount a, 
		Banking b 
	WHERE 
		a.BankingAccountID = b.SubBankingAccountID AND 
		(b.BankingAccountID = @BankingAccountID OR
		b.SubBankingAccountID = @BankingAccountID)
		/*
b.SubBankingAccountID IN 
			(SELECT 
					c.SubBankingAccountID 
			FROM 
				Banking c
			WHERE 
				c.BankingAccountID = @BankingAccountID)
		*/
			GROUP BY a.BankingAccountName
	ORDER BY
		a.BankingAccountName


GO

