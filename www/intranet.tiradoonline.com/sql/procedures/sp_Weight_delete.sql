IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Weight_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_Weight_delete;
GO

CREATE PROCEDURE sp_Weight_delete
	@WeightID	INT
AS

	DELETE FROM Weight WHERE WeightID = @WeightID

GO

--EXEC sp_Weight_delete '8DA84CA7-4462-4C0D-B96E-128251A2D247'
