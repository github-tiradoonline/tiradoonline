IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Weight_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Weight_insert;
GO



CREATE PROCEDURE [dbo].[sp_Weight_insert]
	@UserID			INT = NULL,
	@WeightDateTime		DATETIME,
	@Weight			INT, 
	@WeightLocation		VARCHAR(100), 
	@WeightComments		VARCHAR(2000)
AS
	
	INSERT INTO Weight
		(UserID, WeightDateTime, Weight, WeightLocation, WeightComments)
	VALUES
		(@UserID, @WeightDateTime, @Weight, @WeightLocation, @WeightComments)

	SELECT @@IDENTITY;


GO

