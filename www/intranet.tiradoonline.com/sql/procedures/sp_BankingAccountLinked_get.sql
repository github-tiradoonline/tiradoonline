IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccountLinked_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccountLinked_get;
GO



CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_get]
	@BankingAccountID		INT,
	@BankingAccountLinkedID		INT = NULL

AS

	IF @BankingAccountLinkedID IS NULL
		BEGIN	
			SELECT
				BankingAccountLinkedID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ' - ' + Email + ')' FROM Users WHERE UserID = BankingAccountLinked.LinkedUserID)
			FROM
				BankingAccountLinked
			WHERE
				BankingAccountID = @BankingAccountID
		END
	ELSE
		BEGIN	
			SELECT
				BankingAccountLinkedID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ' - ' + Email + ')' FROM Users WHERE UserID = BankingAccountLinked.LinkedUserID)
			FROM
				BankingAccountLinked
			WHERE
				BankingAccountLinkedID = @BankingAccountLinkedID
		END

GO

--exec sp_BankingAccountLinked_get 1001