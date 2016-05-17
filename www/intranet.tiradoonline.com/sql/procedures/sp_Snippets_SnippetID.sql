IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Snippets_SnippetID' AND TYPE = 'P')
DROP PROCEDURE sp_Snippets_SnippetID;
GO


CREATE PROCEDURE [dbo].[sp_Snippets_SnippetID]
	@SnippetID	INT
AS
	SELECT 
		SnippetID,
		SnippetGroupID,
		SnippetName,
		Snippet
	FROM 
		Snippets
	WHERE
		SnippetID = @SnippetID;


GO

