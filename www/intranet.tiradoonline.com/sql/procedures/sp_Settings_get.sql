IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Settings_get' AND TYPE = 'P')
DROP PROCEDURE sp_Settings_get;
GO



CREATE PROCEDURE [dbo].[sp_Settings_get]
	@UserID			INT
AS

	SELECT 
		*
	FROM
		Settings
	WHERE
		UserID = @UserID;



GO

