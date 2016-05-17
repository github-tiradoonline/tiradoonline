IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccountLinked_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccountLinked_get;
GO



CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_get]
         @BankingAccountID              INT
AS

	SELECT
		BankingAccountLinkedID,
		Email
	FROM
		BankingAccountLinked
	WHERE
		BankingAccountID = @BankingAccountID		
	ORDER BY
		Email


GO

