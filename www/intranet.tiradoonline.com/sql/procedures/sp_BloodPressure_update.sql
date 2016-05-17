IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BloodPressure_update' AND TYPE = 'P')
DROP PROCEDURE sp_BloodPressure_update;
GO



CREATE PROCEDURE [dbo].[sp_BloodPressure_update]
	@BloodPressureID			INT,
	@BloodPressureDateTime	DATETIME,
	@BloodPressureTop		SMALLINT, 
	@BloodPressureBottom		SMALLINT, 
	@BloodPressureComments	VARCHAR(2000)
AS
	
	UPDATE BloodPressure SET
		BloodPressureDateTime = @BloodPressureDateTime, 
		BloodPressureTop = @BloodPressureTop,
		BloodPressureBottom = @BloodPressureBottom,
		BloodPressureComments = @BloodPressureComments
	WHERE
		BloodPressureID = @BloodPressureID;


GO

