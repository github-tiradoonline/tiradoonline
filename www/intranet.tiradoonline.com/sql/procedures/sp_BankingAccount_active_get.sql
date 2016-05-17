IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_active_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_active_get;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_active_get]
	@UserID			INT,
	@Active			BIT,
	@Administrator		BIT
AS

	IF @Administrator = 0
		BEGIN
	
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.UserID = @UserID AND
				a.Active = @Active
			ORDER BY
				a.BankingAccountName;
		END

	ELSE

		BEGIN
	
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.Active = @Active
			ORDER BY
				a.BankingAccountName;
		END



GO

