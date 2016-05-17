IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_POP3EmailFolder_POP3EmailAccountID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_POP3EmailFolder_POP3EmailAccountID_get;
GO

CREATE PROCEDURE sp_POP3EmailFolder_POP3EmailAccountID_get
	@POP3EmailAccountID		INT

AS
	SELECT
		POP3EmailFolderID,
		POP3EmailFolderName
	FROM
		POP3EmailFolder
	WHERE
		Active = 1
		AND POP3EmailAccountID = @POP3EmailAccountID
	ORDER BY
		POP3EmailFolderName;


GO

EXEC sp_POP3EmailFolder_POP3EmailAccountID_get 1001