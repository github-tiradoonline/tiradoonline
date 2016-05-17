IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Unit_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Unit_insert;
GO



CREATE PROCEDURE [dbo].[sp_Unit_insert] 
	@UserID				INT,
	@UnitName 			VARCHAR(20)
AS
	
	INSERT INTO Unit 
		(UserID, UnitName)
	VALUES
		(@UserID, @UnitName);

	SELECT @@IDENTITY;



GO

