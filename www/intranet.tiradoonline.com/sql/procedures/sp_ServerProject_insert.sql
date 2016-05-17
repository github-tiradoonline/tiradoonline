IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerProject_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerProject_insert;
GO

CREATE PROCEDURE sp_ServerProject_insert
	@UserID				INT,
	@ServerProjectName		VARCHAR(50),
	@ServerProjectNotes		VARCHAR(MAX)
AS

	IF NOT EXISTS (SELECT 1 FROM ServerProject WHERE UserID = @UserID AND ServerProjectName = @ServerProjectName)
		BEGIN
			INSERT INTO ServerProject
				(UserID, ServerProjectName, ServerProjectNotes)
			VALUES
				(@UserID, @ServerProjectName, @ServerProjectNotes);
		
			SELECT @@IDENTITY;
		END
	ELSE
		SELECT 0;
GO

		