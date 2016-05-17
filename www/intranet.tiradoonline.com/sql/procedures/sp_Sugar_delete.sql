IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sugar_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_Sugar_delete;
GO

CREATE PROCEDURE sp_Sugar_delete
	@SugarID	INT
AS

	DELETE FROM Sugar WHERE SugarID = @SugarID

GO

--EXEC sp_Sugar_delete '8DA84CA7-4462-4C0D-B96E-128251A2D247'
