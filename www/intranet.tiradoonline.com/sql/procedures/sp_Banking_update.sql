IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_update' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_update;
GO




CREATE PROCEDURE [dbo].[sp_Banking_update]
	@UserID				INT,
	@BankingID			INT,
	@BankingDate			SMALLDATETIME, 
	@TransactionID			INT OUTPUT, 
	@TransactionText		VARCHAR(100), 
	@Comment			VARCHAR(255), 
	@Payment			NUMERIC(8,2),
	@BankingFile			BIT,
	@BankingFileName		VARCHAR(200)
AS
	
	IF @TransactionID IS NULL AND @TransactionText <> ''
		BEGIN
			EXEC sp_Transactions_insert @TransactionID OUTPUT, @UserID, @TransactionText;
		END
	

	UPDATE Banking SET
		BankingDate = @BankingDate, 
		TransactionID = @TransactionID, 
		Comment = @Comment, 
		Payment = @Payment, 
		BankingFile = @BankingFile, 
		BankingFileName = @BankingFileName, 
		update_dt = GETDATE()
	WHERE 
		BankingID = @BankingID;




GO

