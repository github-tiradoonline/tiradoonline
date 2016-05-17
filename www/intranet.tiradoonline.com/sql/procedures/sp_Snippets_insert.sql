IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Snippets_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Snippets_insert;
GO


CREATE PROCEDURE [dbo].[sp_Snippets_insert]
	@SnippetGroupID		INT,
	@SnippetName		VARCHAR(100),
	@Snippet		VARCHAR(8000)
AS
	INSERT INTO Snippets 
		(SnippetGroupID, SnippetName, Snippet) 
	VALUES 
		(@SnippetGroupID, @SnippetName, @Snippet);

	SELECT @@IDENTITY


GO

