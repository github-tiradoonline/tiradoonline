IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Server_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_Server_insert;
GO

CREATE PROCEDURE sp_Server_insert
	@ServerProjectID	INT,
	@ServerName		VARCHAR(50),
	@ServerNotes		VARCHAR(MAX)
AS

	IF NOT EXISTS (SELECT 1 FROM Server WHERE ServerProjectID = @ServerProjectID AND ServerName = @ServerName)
		BEGIN
			INSERT INTO Server
				(ServerProjectID, ServerName, ServerNotes)
			VALUES
				(@ServerProjectID, @ServerName, @ServerNotes);

			SELECT @@IDENTITY;
		END
	ELSE
		SELECT ServerID = 0
GO

		