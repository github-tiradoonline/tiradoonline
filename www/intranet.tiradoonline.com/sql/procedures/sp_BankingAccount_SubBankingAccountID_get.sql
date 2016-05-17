IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_SubBankingAccountID_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_SubBankingAccountID_get;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_SubBankingAccountID_get]
	@UserID				INT,
	@BankingAccountID		INT
AS

	SELECT
		BankingAccountID,
		BankingAccountName
	FROM 
		BankingAccount
	WHERE
		UserID = @UserID AND
		BankingAccountID <> @BankingAccountID AND
		Active = 1
	ORDER BY
		BankingAccountName;


GO

