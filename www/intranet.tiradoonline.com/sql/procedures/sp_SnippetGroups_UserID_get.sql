IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SnippetGroups_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_SnippetGroups_UserID_get;
GO


CREATE PROCEDURE [dbo].[sp_SnippetGroups_UserID_get]
	@UserID		INT
AS
	SELECT
		a.SnippetGroupID, 
		a.SnippetGroupName,
		b.SnippetName,
		TotalSnippets = (SELECT COUNT(*) FROM Snippets b WHERE b.SnippetGroupID = a.SnippetGroupID)
	FROM 
		SnippetGroups a,
		Snippets b
	WHERE 
		a.SnippetGroupID = b.SnippetGroupID AND
		a.UserID = @UserID
	ORDER BY 
		a.SnippetGroupName;


GO

