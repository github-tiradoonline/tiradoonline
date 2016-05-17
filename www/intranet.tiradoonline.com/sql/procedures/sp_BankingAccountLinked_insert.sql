IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccountLinked_insert' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccountLinked_insert;
GO



CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_insert]
	@BankingAccountID		INT,
	@LinkedUserID			INT
AS
	
	INSERT INTO BankingAccountLinked
		(BankingAccountID, LinkedUserID)
	VALUES
		(@BankingAccountID, @LinkedUserID);

GO

--exec sp_BankingAccountLinked_insert 1001