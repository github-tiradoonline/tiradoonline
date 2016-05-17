IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Unit_update' AND TYPE = 'P')
DROP PROCEDURE sp_Unit_update;
GO



CREATE PROCEDURE [dbo].[sp_Unit_update] 
	@UnitID				INT,
	@UnitName 			VARCHAR(20)
AS
	
	UPDATE Unit SET
		UnitName = @UnitName
	WHERE
		UnitID = @UnitID;



GO

