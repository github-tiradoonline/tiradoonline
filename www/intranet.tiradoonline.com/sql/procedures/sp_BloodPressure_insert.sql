IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BloodPressure_insert' AND TYPE = 'P')
DROP PROCEDURE sp_BloodPressure_insert;
GO



CREATE PROCEDURE [dbo].[sp_BloodPressure_insert]
	@UserID			INT = NULL,
	@BloodPressureDateTime	DATETIME,
	@BloodPressureTop		SMALLINT, 
	@BloodPressureBottom		SMALLINT, 
	@BloodPressureComments	VARCHAR(2000)
AS
	
	INSERT INTO BloodPressure
		(UserID, BloodPressureDateTime, BloodPressureTop, BloodPressureBottom, BloodPressureComments)
	VALUES
		(@UserID, @BloodPressureDateTime, @BloodPressureTop, @BloodPressureBottom, @BloodPressureComments)

	SELECT @@IDENTITY;


GO

