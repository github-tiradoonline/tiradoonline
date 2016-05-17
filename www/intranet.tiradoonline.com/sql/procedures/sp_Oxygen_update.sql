IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Oxygen_update' AND TYPE = 'P')
DROP PROCEDURE sp_Oxygen_update;
GO



CREATE PROCEDURE [dbo].[sp_Oxygen_update]
	@OxygenID			INT,
	@OxygenDateTime	DATETIME,
	@Oxygen		SMALLINT, 
	@OxygenComments	VARCHAR(2000)
AS
	
	UPDATE Oxygen SET
		OxygenDateTime = @OxygenDateTime, 
		Oxygen = @Oxygen,
		OxygenComments = @OxygenComments
	WHERE
		OxygenID = @OxygenID;


GO

