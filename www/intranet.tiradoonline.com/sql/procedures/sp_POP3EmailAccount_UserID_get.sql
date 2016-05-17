IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_POP3EmailAccount_UserID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_POP3EmailAccount_UserID_get;
GO

CREATE PROCEDURE sp_POP3EmailAccount_UserID_get
	@UserID			INT

AS
	SELECT
		POP3EmailAccountID,
		POP3EmailAccountName
	FROM
		POP3EmailAccount
	WHERE
		Active = 1
		AND UserID = @UserID
	ORDER BY
		POP3EmailAccountName;


GO

EXEC sp_POP3EmailAccount_UserID_get 1001