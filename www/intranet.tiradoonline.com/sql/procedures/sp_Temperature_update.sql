IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Temperature_update' AND TYPE = 'P')
DROP PROCEDURE sp_Temperature_update;
GO



CREATE PROCEDURE [dbo].[sp_Temperature_update]
	@TemperatureID			INT,
	@TemperatureDateTime	DATETIME,
	@Temperature		NUMERIC(5,1), 
	@TemperatureComments	VARCHAR(2000)
AS
	
	UPDATE Temperature SET
		TemperatureDateTime = @TemperatureDateTime, 
		Temperature = @Temperature,
		TemperatureComments = @TemperatureComments
	WHERE
		TemperatureID = @TemperatureID;


GO

