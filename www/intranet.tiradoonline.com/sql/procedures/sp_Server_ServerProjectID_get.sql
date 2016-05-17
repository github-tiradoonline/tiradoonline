IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Server_ServerProjectID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Server_ServerProjectID_get;
GO

CREATE PROCEDURE sp_Server_ServerProjectID_get
	@ServerProjectID			INT
AS

	SELECT 
		*
	FROM
		Server
	WHERE
		ServerProjectID = @ServerProjectID
	ORDER BY
		ServerName;
GO

exec sp_Server_ServerProjectID_get 1004