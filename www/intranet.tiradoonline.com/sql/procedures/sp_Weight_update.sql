IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Weight_update' AND TYPE = 'P')
DROP PROCEDURE sp_Weight_update;
GO



CREATE PROCEDURE [dbo].[sp_Weight_update]
	@WeightID			INT,
	@WeightDateTime	DATETIME,
	@Weight		INT, 
	@WeightLocation VARCHAR(200),
	@WeightComments	VARCHAR(2000)
AS
	
	UPDATE Weight SET
		WeightDateTime = @WeightDateTime, 
		Weight = @Weight,
		WeightLocation = @WeightLocation,
		WeightComments = @WeightComments
	WHERE
		WeightID = @WeightID;


GO

