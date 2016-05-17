IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerProject_UserID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerProject_UserID_get;
GO

CREATE PROCEDURE sp_ServerProject_UserID_get
	@UserID			INT
AS

	SELECT 
		*
	FROM
		ServerProject
	WHERE
		UserID = @UserID
	ORDER BY
		ServerProjectName;
GO

exec sp_ServerProject_UserID_get 1001