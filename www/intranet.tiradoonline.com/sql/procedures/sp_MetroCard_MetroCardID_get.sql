IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MetroCard_MetroCardID_get' AND TYPE = 'P')
DROP PROCEDURE sp_MetroCard_MetroCardID_get;
GO



CREATE PROCEDURE sp_MetroCard_MetroCardID_get
	@MetroCardID			INT
AS
	
	SELECT
		* 
	FROM
		MetroCard
	WHERE
		MetroCardID = @MetroCardID

GO

EXEC sp_MetroCard_MetroCardID_get 1001