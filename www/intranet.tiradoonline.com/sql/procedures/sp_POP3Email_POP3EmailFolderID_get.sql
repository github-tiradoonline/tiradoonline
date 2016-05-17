IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_POP3Email_POP3EmailFolderID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_POP3Email_POP3EmailFolderID_get;
GO

CREATE PROCEDURE sp_POP3Email_POP3EmailFolderID_get
	@POP3FolderID		INT = NULL

AS

	SELECT
		*
	FROM
		POP3Email
	WHERE
		Active = 1
		AND POP3EmailFolderID = POP3EmailFolderID
	ORDER BY
		CONVERT(DATETIME, POP3EmailMessageDateTime) DESC;

GO

EXEC sp_POP3Email_POP3EmailFolderID_get 1001