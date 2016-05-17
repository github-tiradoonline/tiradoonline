IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Temperature_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_Temperature_delete;
GO

CREATE PROCEDURE sp_Temperature_delete
	@TemperatureID	INT
AS

	DELETE FROM Temperature WHERE TemperatureID = @TemperatureID

GO

--EXEC sp_Temperature_delete '8DA84CA7-4462-4C0D-B96E-128251A2D247'
