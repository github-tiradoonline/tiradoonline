IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccountLinked_insert' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccountLinked_insert;
GO



CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_insert]
        @BankingAccountID              	INT,
	@Email				VARCHAR(50)
AS

	INSERT INTO BankingAccountLinked
		(BankingAccountID, Email)
	VALUES
		(@BankingAccountID, @Email)


GO

