IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_RecoveryPrograms_update' AND TYPE = 'P')
DROP PROCEDURE sp_RecoveryPrograms_update;
GO


CREATE PROCEDURE sp_RecoveryPrograms_update
	@RecoveryProgramID		INT,
	@ProgramName			VARCHAR(50),
	@StartDate			DATETIME,
	@EndDate			DATETIME,
	@SoberDate			DATETIME
AS
	

	UPDATE RecoveryPrograms SET
		ProgramName = @ProgramName, 
		start_dt = @StartDate,
		end_dt = @EndDate,
		sober_dt = @SoberDate
	WHERE 
		RecoveryProgramID = @RecoveryProgramID
GO

--EXEC sp_RecoveryPrograms_update 1001