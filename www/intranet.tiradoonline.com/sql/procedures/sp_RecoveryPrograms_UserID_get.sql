IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_RecoveryPrograms_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_RecoveryPrograms_UserID_get;
GO


CREATE PROCEDURE sp_RecoveryPrograms_UserID_get
	@UserID		INT
AS
	
	SELECT 
		RecoveryProgramID,
		ProgramName,
		StartDate = start_dt,
		EndDate = end_dt,
		SoberDate = sober_dt
	FROM 
		RecoveryPrograms
	WHERE
		UserID = @UserID;


GO

EXEC sp_RecoveryPrograms_UserID_get 1001