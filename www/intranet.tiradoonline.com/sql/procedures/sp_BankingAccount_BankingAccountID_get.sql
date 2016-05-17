IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_BankingAccountID_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_BankingAccountID_get;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_BankingAccountID_get]
	@BankingAccountID	INT

AS

	SELECT
		TotalBanking = (SELECT SUM(Payment) FROM Banking WHERE BankingAccountID = @BankingAccountID),
		*
	FROM
		BankingAccount
	WHERE
		BankingAccountID = @BankingAccountID;



GO

