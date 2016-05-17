IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Oxygen_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Oxygen_insert;
GO



CREATE PROCEDURE [dbo].[sp_Oxygen_insert]
	@UserID			INT = NULL,
	@OxygenDateTime	DATETIME,
	@Oxygen		SMALLINT, 
	@OxygenComments	VARCHAR(2000)
AS
	
	INSERT INTO Oxygen
		(UserID, OxygenDateTime, Oxygen, OxygenComments)
	VALUES
		(@UserID, @OxygenDateTime, @Oxygen, @OxygenComments)

	SELECT @@IDENTITY;


GO

exec sp_Oxygen_insert 1001, '3/13/2016 8:48:42 AM', 95, 'oxygen comments'