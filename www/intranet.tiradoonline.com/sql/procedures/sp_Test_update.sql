IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Test_update' AND TYPE = 'P')
DROP PROCEDURE sp_Test_update;
GO



CREATE PROCEDURE [dbo].[sp_Test_update]
	@TestID				INT,
	@TestTypeID 			INT,
	@TestResultID			INT,
	@TestDate        		SMALLDATETIME,
	@TestLocation			VARCHAR(50), 
	@TestComments			VARCHAR(200) 
AS
	
	UPDATE Test SET
		TestTypeID = @TestTypeID,
		TestResultID = @TestResultID, 
		TestDate = @TestDate, 
		TestLocation = @TestLocation,
		TestComments = @TestComments
	WHERE
		TestID = @TestID;



GO

