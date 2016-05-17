IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_RecoveryPrograms_get' AND TYPE = 'P')
DROP PROCEDURE sp_RecoveryPrograms_get;
GO


CREATE PROCEDURE sp_RecoveryPrograms_get
	@RecoveryProgramID		INT = NULL
AS
	
	IF @RecoveryProgramID IS NULL
		 BEGIN
			SELECT 
				RecoveryProgramID,
				ProgramName,
				StartDate = start_dt,
				EndDate = end_dt,
				SoberDate = sober_dt
			FROM 
				RecoveryPrograms
		END
	ELSE
		BEGIN
			SELECT 
				RecoveryProgramID,
				ProgramName,
				StartDate = start_dt,
				EndDate = end_dt,
				SoberDate = sober_dt
			FROM 
				RecoveryProgramS
			WHERE
				RecoveryProgramID = @RecoveryProgramID;
		END


GO

EXEC sp_RecoveryPrograms_get 1001