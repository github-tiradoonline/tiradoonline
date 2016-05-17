IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_delete' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_delete;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_delete] 
	@BankingAccountID	INT
AS

	/*
	BEGIN TRANSACTION DeleteBankingAccount

	DECLARE @BankingAccountName		VARCHAR(50);

	DELETE FROM Banking WHERE BankingAccountID = @BankingAccountID;
	DELETE FROM BankingAccount WHERE BankingAccountID = @BankingAccountID;

	IF @@ERROR = 0
		COMMIT TRANSACTION DeleteBankingAccount;
	ELSE
		ROLLBACK TRANSACTION DeleteBankingAccount;

	SELECT @BankingAccountName;
	*/
	UPDATE BankingAccount SET Active = 0  WHERE BankingAccountID = @BankingAccountID;
	SELECT BankingAccountName FROM BankingAccount WHERE BankingAccountID = @BankingAccountID;


GO

