IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sites_delete' AND TYPE = 'P')
DROP PROCEDURE sp_Sites_delete;
GO



CREATE PROCEDURE [dbo].[sp_Sites_delete]
	@SiteID	INT
AS

	DELETE FROM 
		Sites 
	WHERE 
		SiteID = @SiteID;



GO

