IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sugar_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Sugar_insert;
GO



CREATE PROCEDURE [dbo].[sp_Sugar_insert]
	@UserID			INT = NULL,
	@SugarDateTime	DATETIME,
	@Sugar		SMALLINT, 
	@SugarComments	VARCHAR(2000)
AS
	
	INSERT INTO Sugar
		(UserID, SugarDateTime, Sugar, SugarComments)
	VALUES
		(@UserID, @SugarDateTime, @Sugar, @SugarComments)

	SELECT @@IDENTITY;


GO

