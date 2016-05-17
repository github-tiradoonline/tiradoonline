IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_EmailTemplates_get' AND TYPE = 'P')
DROP PROCEDURE sp_EmailTemplates_get;
GO




CREATE PROCEDURE [dbo].[sp_EmailTemplates_get]
	@UserID				INT
AS


	SELECT * FROM EmailTemplates WHERE UserID = @UserID;


GO

