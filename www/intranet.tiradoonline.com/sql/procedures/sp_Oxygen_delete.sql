IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Oxygen_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_Oxygen_delete;
GO

CREATE PROCEDURE sp_Oxygen_delete
	@OxygenID	INT
AS

	DELETE FROM Oxygen WHERE OxygenID = @OxygenID

GO

--EXEC sp_Oxygen_delete '8DA84CA7-4462-4C0D-B96E-128251A2D247'
