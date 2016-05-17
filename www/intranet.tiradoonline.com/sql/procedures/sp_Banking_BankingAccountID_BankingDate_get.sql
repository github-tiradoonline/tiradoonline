IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_BankingAccountID_BankingDate_get' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_BankingAccountID_BankingDate_get;
GO




CREATE PROCEDURE [dbo].[sp_Banking_BankingAccountID_BankingDate_get]
	@BankingAccountID		INT,
	@BankingDate			SMALLDATETIME
AS

	SELECT
		a.BankingID,
		BankingAccountID = @BankingAccountID,
		a.SubBankingAccountID,	
		BankingAccountName = (SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = @BankingAccountID),
		SubAccountName = CASE 
					WHEN SubBankingAccountID IS NOT NULL THEN
						(SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = a.SubBankingAccountID)
					ELSE
						NULL
				END,
		a.BankingDate,
		a.Payment,
		a.Comment,
		b.Description,
		a.BankingFile,
		a.BankingFileName
	FROM 
		Banking a, 
		Transactions b
	WHERE
		DATEPART(month, a.BankingDate) = MONTH(@BankingDate) AND 
		DATEPART(year, a.BankingDate) = YEAR(@BankingDate) AND 
		a.TransactionID = b.TransactionID AND
		(a.BankingAccountID = @BankingAccountID OR
		a.SubBankingAccountID = @BankingAccountID)
	ORDER BY
		a.BankingDate,
		a.create_dt;



GO

