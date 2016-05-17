IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MetroCard_update' AND TYPE = 'P')
DROP PROCEDURE sp_MetroCard_update;
GO



CREATE PROCEDURE sp_MetroCard_update
	@MetroCardID			INT,
	@MetroCardDate			DATETIME
AS
	
	UPDATE MetroCard SET
		MetroCardDate = @MetroCardDate
	WHERE
		MetroCardID = @MetroCardID;


GO

