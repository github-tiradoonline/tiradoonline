IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Server_ServerID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Server_ServerID_get;
GO

CREATE PROCEDURE sp_Server_ServerID_get
	@ServerID			INT
AS

	SELECT 
		*
	FROM
		Server
	WHERE
		ServerID = @ServerID
	ORDER BY
		ServerName;
GO

exec sp_Server_ServerID_get 1014