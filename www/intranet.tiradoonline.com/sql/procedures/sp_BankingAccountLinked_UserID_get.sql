IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccountLinked_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccountLinked_UserID_get;
GO



CREATE PROCEDURE [dbo].[sp_BankingAccountLinked_UserID_get]
	@UserID				INT,
	@BankingAccountID		INT = NULL
AS

	SELECT
		UserID,
		FullName = FirstName + ' ' + LastName + ' (' + UserName + ' - ' + Email + ')' 
	FROM
		Users
	WHERE
		UserID <> @UserID
		AND Active = 1
		AND UserID NOT IN
		(
			SELECT
				LinkedUserID
			FROM
				BankingAccountLinked
			WHERE
				BankingAccountID = @BankingAccountID
				
		)
	ORDER BY
		FullName;
GO

exec sp_BankingAccountLinked_UserID_get 1001