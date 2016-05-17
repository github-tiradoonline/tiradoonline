IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_TestType_update' AND TYPE = 'P')
DROP PROCEDURE sp_TestType_update;
GO



CREATE PROCEDURE [dbo].[sp_TestType_update] 
	@TestTypeID				INT,
	@TestTypeName 			VARCHAR(20)
AS
	
	UPDATE TestType SET
		TestTypeName = @TestTypeName
	WHERE
		TestTypeID = @TestTypeID;



GO

