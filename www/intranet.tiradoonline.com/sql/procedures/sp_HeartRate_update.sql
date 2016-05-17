IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HeartRate_update' AND TYPE = 'P')
DROP PROCEDURE sp_HeartRate_update;
GO



CREATE PROCEDURE [dbo].[sp_HeartRate_update]
	@HeartRateID			INT,
	@HeartRateDateTime	DATETIME,
	@HeartRate		SMALLINT, 
	@HeartRateComments	VARCHAR(2000)
AS
	
	UPDATE HeartRate SET
		HeartRateDateTime = @HeartRateDateTime, 
		HeartRate = @HeartRate,
		HeartRateComments = @HeartRateComments
	WHERE
		HeartRateID = @HeartRateID;


GO

