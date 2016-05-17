IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFileDirectory_UserID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFileDirectory_UserID_get;
GO

CREATE PROCEDURE sp_MediaFileDirectory_UserID_get
	@UserID			INT
AS
	
	SELECT
		MediaFileDirectoryName
	FROM
		MediaFileDirectory
	WHERE
		UserID = @UserID
GO

EXEC sp_MediaFileDirectory_UserID_get 1001