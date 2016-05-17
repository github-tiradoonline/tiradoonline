IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_TestType_insert' AND TYPE = 'P')
DROP PROCEDURE sp_TestType_insert;
GO



CREATE PROCEDURE [dbo].[sp_TestType_insert] 
	@UserID				INT,
	@TestTypeName 			VARCHAR(20)
AS
	
	INSERT INTO TestType 
		(UserID, TestTypeName)
	VALUES
		(@UserID, @TestTypeName);

	SELECT @@IDENTITY;



GO

