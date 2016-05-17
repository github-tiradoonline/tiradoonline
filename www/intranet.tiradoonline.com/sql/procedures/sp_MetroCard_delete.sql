IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MetroCard_delete' AND TYPE = 'P')
DROP PROCEDURE sp_MetroCard_delete;
GO



CREATE PROCEDURE sp_MetroCard_delete
	@MetroCardID			INT
AS
	
	DELETE FROM MetroCard WHERE MetroCardID = @MetroCardID;

GO

