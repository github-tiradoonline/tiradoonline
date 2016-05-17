IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Temperature_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Temperature_insert;
GO



CREATE PROCEDURE [dbo].[sp_Temperature_insert]
	@UserID			INT = NULL,
	@TemperatureDateTime	DATETIME,
	@Temperature		NUMERIC(5,1), 
	@TemperatureComments	VARCHAR(2000)
AS
	
	INSERT INTO Temperature
		(UserID, TemperatureDateTime, Temperature, TemperatureComments)
	VALUES
		(@UserID, @TemperatureDateTime, @Temperature, @TemperatureComments)

	SELECT @@IDENTITY;


GO

