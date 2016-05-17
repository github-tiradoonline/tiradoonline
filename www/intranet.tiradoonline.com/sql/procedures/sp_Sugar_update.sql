IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sugar_update' AND TYPE = 'P')
DROP PROCEDURE sp_Sugar_update;
GO



CREATE PROCEDURE [dbo].[sp_Sugar_update]
	@SugarID			INT,
	@SugarDateTime	DATETIME,
	@Sugar		INT, 
	@SugarComments	VARCHAR(2000)
AS
	
	UPDATE Sugar SET
		SugarDateTime = @SugarDateTime, 
		Sugar = @Sugar,
		SugarComments = @SugarComments
	WHERE
		SugarID = @SugarID;


GO

