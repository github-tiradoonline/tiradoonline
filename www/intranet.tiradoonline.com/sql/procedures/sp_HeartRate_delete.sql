IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_HeartRate_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_HeartRate_delete;
GO

CREATE PROCEDURE sp_HeartRate_delete
	@HeartRateID	INT
AS

	DELETE FROM HeartRate WHERE HeartRateID = @HeartRateID

GO

--EXEC sp_HeartRate_delete '8DA84CA7-4462-4C0D-B96E-128251A2D247'
