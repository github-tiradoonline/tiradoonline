IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ServerInformation_ServerInformationID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_ServerInformation_ServerInformationID_get;
GO

CREATE PROCEDURE sp_ServerInformation_ServerInformationID_get
	@ServerInformationID			INT
AS

	SELECT 
		*
	FROM
		ServerInformation
	WHERE
		ServerInformationID = @ServerInformationID
	ORDER BY
		ServerInformationOrderNum;
GO

exec sp_ServerInformation_ServerInformationID_get 1020