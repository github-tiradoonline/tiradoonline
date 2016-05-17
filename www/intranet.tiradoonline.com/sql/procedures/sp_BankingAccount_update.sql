IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_update' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_update;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_update]
	@BankingAccountID	INT,
	@BankingAccountName	VARCHAR(50)
AS

	UPDATE BankingAccount SET
		BankingAccountName = @BankingAccountName
	WHERE
		BankingAccountID = @BankingAccountID



GO

