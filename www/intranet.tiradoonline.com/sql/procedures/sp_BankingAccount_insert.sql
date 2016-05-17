IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_insert' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_insert;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_insert]
	@UserID 		INT,
	@BankingAccountName	VARCHAR(20)
AS

	IF NOT EXISTS (SELECT BankingAccountID FROM BankingAccount WHERE UserID = @UserID AND BankingAccountName = @BankingAccountName)
		BEGIN
			INSERT INTO BankingAccount 
				(UserID, BankingAccountName) 
			VALUES 
				(@UserID, @BankingAccountName);
		END

	SELECT @@IDENTITY AS BankingAccountID, @UserID AS UserID;



GO

