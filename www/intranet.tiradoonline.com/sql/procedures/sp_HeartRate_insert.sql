IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HeartRate_insert' AND TYPE = 'P')
DROP PROCEDURE sp_HeartRate_insert;
GO



CREATE PROCEDURE [dbo].[sp_HeartRate_insert]
	@UserID			INT = NULL,
	@HeartRateDateTime	DATETIME,
	@HeartRate		SMALLINT, 
	@HeartRateComments	VARCHAR(2000)
AS
	
	INSERT INTO HeartRate
		(UserID, HeartRateDateTime, HeartRate, HeartRateComments)
	VALUES
		(@UserID, @HeartRateDateTime, @HeartRate, @HeartRateComments)

	SELECT @@IDENTITY;


GO

