IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MedicineDose_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_MedicineDose_delete;
GO

CREATE PROCEDURE sp_MedicineDose_delete
	@MedicineDoseID	INT
AS

	DELETE FROM MedicineDose WHERE MedicineDoseID = @MedicineDoseID

GO

--EXEC sp_MedicineDose_delete '8DA84CA7-4462-4C0D-B96E-128251A2D247'
