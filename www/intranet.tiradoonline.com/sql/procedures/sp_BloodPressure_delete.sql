IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_BloodPressure_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_BloodPressure_delete;
GO

CREATE PROCEDURE sp_BloodPressure_delete
	@BloodPressureID	INT
AS

	DELETE FROM BloodPressure WHERE BloodPressureID = @BloodPressureID

GO

--EXEC sp_BloodPressure_delete '8DA84CA7-4462-4C0D-B96E-128251A2D247'
