IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_SnippetGroups_insert' AND TYPE = 'P')
DROP PROCEDURE sp_SnippetGroups_insert;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SnippetGroups_insert]
	@UserID			INT,
	@SnippetGroupName	VARCHAR(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO SnippetGroups
		(UserID, SnippetGroupName)
	VALUES
		(@UserID, @SnippetGroupName);

	SELECT @@IDENTITY;
		
END



GO

