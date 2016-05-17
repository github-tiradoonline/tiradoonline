IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BalanceAccount_insert' AND TYPE = 'P')
DROP PROCEDURE sp_BalanceAccount_insert;
GO


CREATE PROCEDURE [dbo].[sp_BalanceAccount_insert]
	@UserID 		INT,
	@BalanceAccountName	VARCHAR(20)
AS

	IF NOT EXISTS (SELECT BalanceAccountID FROM BalanceAccounts WHERE UserID = @UserID AND BalanceAccountName = @BalanceAccountName)
		BEGIN
			INSERT INTO BalanceAccounts 
				(UserID, BalanceAccountName) 
			VALUES 
				(@UserID, @BalanceAccountName);
		END

	SELECT @@IDENTITY AS BalanceAccountID, @UserID AS UserID;



GO

