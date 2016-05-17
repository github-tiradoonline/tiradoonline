IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PageLogs_insert' AND TYPE = 'P')
DROP PROCEDURE sp_PageLogs_insert;
GO


CREATE PROCEDURE [dbo].[sp_PageLogs_insert]
	@UserID			INT,
	@SCRIPT_NAME		VARCHAR(255),
	@REQUEST_METHOD		VARCHAR(10),
	@Template		VARCHAR(100),
	@Action			VARCHAR(100),
	@QUERY_STRING		TEXT,
	@FORM			TEXT,
	@PreviousPage		VARCHAR(2000)

AS
	UPDATE Settings SET

		PreviousPage = @PreviousPage
	WHERE
		UserID = @UserID;
	
	INSERT INTO PageLogs
		(UserID, SCRIPT_NAME, REQUEST_METHOD, Template, Action, QUERY_STRING, FORM)
	VALUES
		(@UserID, @SCRIPT_NAME, @REQUEST_METHOD, @Template, @Action, @QUERY_STRING, @FORM)

	SELECT @@IDENTITY;


GO

