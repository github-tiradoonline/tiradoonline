IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MetroCard_MetroCardProgramID_get' AND TYPE = 'P')
DROP PROCEDURE sp_MetroCard_MetroCardProgramID_get;
GO



CREATE PROCEDURE sp_MetroCard_MetroCardProgramID_get
	@MetroCardProgramID			INT
AS
	
	SELECT
		* 
	FROM
		MetroCard
	WHERE
		MetroCardProgramID = @MetroCardProgramID
	ORDER BY
		MetroCardDate DESC;

GO

EXEC sp_MetroCard_MetroCardProgramID_get 1001