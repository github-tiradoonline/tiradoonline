IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Transactions_import' AND TYPE = 'P')
DROP PROCEDURE sp_Transactions_import;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Transactions_import]
	
AS
BEGIN
	DECLARE @UserID		INT;


	-- =============================================
	-- CREATE NEW TRANSACTIONS TABLE
	-- =============================================
	IF NOT EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Transactions_new' AND TYPE = 'U')
		BEGIN
			CREATE TABLE Transactions_new
			(
				TransactionID			INT IDENTITY(1001, 1) NOT NULL,
				OldTransactionID		INT NOT NULL,
				UserID				INT NOT NULL,
				Description			VARCHAR(1000)
			);
		END
	ELSE
		TRUNCATE TABLE Transactions_new;

	-- =============================================
	-- DECLARE DISTINCT Banking ACCOUNT USER ID CURSOR
	-- =============================================
	SELECT DISTINCT UserID INTO #BankingAccountUsers FROM BankingAccount;

	DECLARE BankingAccount_cursor CURSOR FOR 
		SELECT UserID FROM #BankingAccountUsers;

	OPEN BankingAccount_cursor
	FETCH NEXT FROM BankingAccount_cursor INTO @UserID;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO Transactions_new
				(OldTransactionID, UserID, Description)

			SELECT DISTINCT 
				a.TransactionID AS OldTransactionID, 
				@UserID AS UserID,
				a.Description AS Description
			FROM 
				Transactions a, 
				Banking b, 
				BankingAccount c
			WHERE 
				a.TransactionID = b.TransactionID AND
				b.BankingAccountID = c.BankingAccountID and
				c.UserID = @UserID;
			
			FETCH NEXT FROM BankingAccount_cursor INTO @UserID;
		END

	CLOSE BankingAccount_cursor;
	DEALLOCATE BankingAccount_cursor;

	UPDATE Banking SET TransactionID =
		(
			SELECT
				TransactionID 
			FROM 
				Transactions_new
			WHERE 
				OldTransactionID = Banking.TransactionID AND
				UserID = Banking.UserID
		)
END



GO

