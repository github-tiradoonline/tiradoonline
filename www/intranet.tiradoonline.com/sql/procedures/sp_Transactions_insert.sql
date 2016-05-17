IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Transactions_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Transactions_insert;
GO




CREATE PROCEDURE [dbo].[sp_Transactions_insert]
	@TransactionID		INT OUTPUT,
	@UserID			INT,
	@Description		VARCHAR(100)
AS
	IF NOT EXISTS (SELECT TransactionID FROM Transactions WHERE UserID = @UserID AND Description = @Description)
		BEGIN
			INSERT INTO Transactions
				(UserID, Description) 
			VALUES 
				(@UserID, @Description);
			
			SET @TransactionID = @@IDENTITY;
			SELECT @TransactionID;
		END
	ELSE
		BEGIN
			SELECT @TransactionID = TransactionID FROM Transactions WHERE Description = @Description
		END




GO

