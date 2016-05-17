IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Snippets_get' AND TYPE = 'P')
DROP PROCEDURE sp_Snippets_get;
GO


CREATE PROCEDURE [dbo].[sp_Snippets_get]
	@SnippetGroupID		INT
AS

			SELECT 
				SnippetID,
				SnippetName,
				Snippet
			FROM 
				Snippets
			WHERE
				SnippetGroupID = @SnippetGroupID
			ORDER BY
				SnippetName;


GO

