IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Notes_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Notes_insert;
GO




CREATE PROCEDURE [dbo].[sp_Notes_insert]
	@UserID				INT,
	@NoteName		VARCHAR(100),
	@NoteText		VARCHAR(MAX)
AS
	
	
	INSERT INTO Notes
		(UserID, NoteName, NoteText)
	VALUES
		(@UserID, @NoteName, @NoteText);


	SELECT @@IDENTITY;


GO

