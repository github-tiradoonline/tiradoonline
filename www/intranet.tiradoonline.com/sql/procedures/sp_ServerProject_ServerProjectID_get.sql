IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerProject_ServerProjectID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerProject_ServerProjectID_get;
GO

CREATE PROCEDURE sp_ServerProject_ServerProjectID_get
	@ServerProjectID			INT
AS

	SELECT 
		*
	FROM
		ServerProject
	WHERE
		ServerProjectID = @ServerProjectID
	ORDER BY
		ServerProjectName;
GO

exec sp_ServerProject_ServerProjectID_get 1020