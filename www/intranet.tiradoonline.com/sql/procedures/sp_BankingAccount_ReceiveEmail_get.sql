IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BankingAccount_ReceiveEmail_get' AND TYPE = 'P')
DROP PROCEDURE sp_BankingAccount_ReceiveEmail_get;
GO


CREATE PROCEDURE [dbo].[sp_BankingAccount_ReceiveEmail_get]
	@UserID		INT = NULL
AS

	IF @UserID IS NULL 
		BEGIN
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				Email = (SELECT Email FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.ReceiveEmails = 1
				AND a.Active = 1
			ORDER BY
				a.BankingAccountName;
		END
	ELSE
		BEGIN
			SELECT
				a.BankingAccountID,
				FullName = (SELECT FirstName + ' ' + LastName + ' (' + UserName + ')' FROM Users WHERE UserID = a.UserID),
				Email = (SELECT Email FROM Users WHERE UserID = a.UserID),
				a.BankingAccountName,
				Balance = (SELECT ISNULL(SUM(Payment), 0) FROM Banking WHERE BankingAccountID = a.BankingAccountID),
				a.ReceiveEmails,
				a.UserID
			FROM
				BankingAccount a
			WHERE
				a.UserID = @UserID
				AND a.ReceiveEmails = 1
				AND a.Active = 1
			ORDER BY
				a.BankingAccountName;
		END
		


GO

