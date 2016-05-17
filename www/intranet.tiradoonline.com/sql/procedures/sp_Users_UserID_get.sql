IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Users_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Users_UserID_get;
GO



CREATE PROCEDURE [dbo].[sp_Users_UserID_get]
	@UserID		INT
AS

	SELECT
		* 
	FROM 
		Users
	WHERE
		UserID = @UserID



GO

