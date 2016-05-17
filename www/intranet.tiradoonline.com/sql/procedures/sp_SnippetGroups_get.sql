IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SnippetGroups_get' AND TYPE = 'P')
DROP PROCEDURE sp_SnippetGroups_get;
GO


CREATE PROCEDURE [dbo].[sp_SnippetGroups_get]
	@UserID		INT
AS
	SELECT
		a.SnippetGroupID, 
		a.UserID,
		a.SnippetGroupName,
		TotalSnippets = (SELECT COUNT(*) FROM Snippets b WHERE b.SnippetGroupID = a.SnippetGroupID)
	FROM 
		SnippetGroups a
	WHERE 
		a.UserID = @UserID
	ORDER BY 
		a.SnippetGroupName;


GO

