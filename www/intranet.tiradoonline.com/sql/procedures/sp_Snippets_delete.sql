IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Snippets_delete' AND TYPE = 'P')
DROP PROCEDURE sp_Snippets_delete;
GO


CREATE PROCEDURE [dbo].[sp_Snippets_delete]
	@SnippetID	INT
AS
	DELETE FROM Snippets WHERE SnippetID = @SnippetID;


GO

