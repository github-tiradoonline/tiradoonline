IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Snippets_SnippetID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Snippets_SnippetID_get;
GO


CREATE PROCEDURE [dbo].[sp_Snippets_SnippetID_get]
	@SnippetID	INT
AS
	SELECT 
		SnippetID,
		SnippetGroupID,
		SnippetGroupName = (SELECT SnippetGroupName FROM SnippetGroups WHERE SnippetGroupID = Snippets.SnippetGroupID),
		SnippetName,
		Snippet
	FROM 
		Snippets
	WHERE
		SnippetID = @SnippetID;


GO

EXEC sp_Snippets_SnippetID_get 1229