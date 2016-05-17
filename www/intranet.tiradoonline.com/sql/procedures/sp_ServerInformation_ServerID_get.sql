IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerInformation_ServerID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerInformation_ServerID_get;
GO

CREATE PROCEDURE sp_ServerInformation_ServerID_get
	@ServerID			INT
AS

	SELECT 
		*,
		TotalServerInformations = 
			(
				SELECT
					COUNT(*)
				FROM
					ServerInformation
				WHERE
					ServerID = @ServerID
			)

	FROM
		ServerInformation
	WHERE
		ServerID = @ServerID
	ORDER BY
		ServerInformationOrderNum;
GO

exec sp_ServerInformation_ServerID_get 1014