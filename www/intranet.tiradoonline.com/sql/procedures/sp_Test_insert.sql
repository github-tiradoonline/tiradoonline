IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Test_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Test_insert;
GO



CREATE PROCEDURE [dbo].[sp_Test_insert]
	@UserID				INT,
	@TestTypeID 			INT,
	@TestResultID			INT,
	@TestDate        		SMALLDATETIME,
	@TestLocation			VARCHAR(50), 
	 @TestComments			VARCHAR(200) 
AS
	
	INSERT INTO Test 
		(UserID, TestTypeID, TestDate, TestLocation, TestResultID, TestComments)
	VALUES
		(@UserID, @TestTypeID, @TestDate, @TestLocation, @TestResultID, @TestComments);

	SELECT @@IDENTITY;



GO

