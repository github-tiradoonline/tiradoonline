IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccountLinked_delete' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccountLinked_delete;
GO



CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_delete]
	@BankingAccountLinkedID		INT
AS
	
	DELETE FROM BankingAccountLinked WHERE BankingAccountLinkedID = @BankingAccountLinkedID;

GO

--exec sp_BankingAccountLinked_delete 1001