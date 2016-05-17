IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_insert;
GO




CREATE PROCEDURE [dbo].[sp_Banking_insert]
	@UserID				INT,
	@BankingAccountID		INT, 
	@SubBankingAccountID		INT, 
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
	
	INSERT INTO Banking
		(BankingAccountID, SubBankingAccountID, BankingDate, TransactionID, Comment, Payment, BankingFile, BankingFileName, update_dt) 
	VALUES 
		(@BankingAccountID, @SubBankingAccountID, @BankingDate, @TransactionID, @Comment, @Payment, @BankingFile, @BankingFileName, GETDATE());

	SELECT @@IDENTITY;



GO

