IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_RecoveryPrograms_insert' AND TYPE = 'P')
DROP PROCEDURE sp_RecoveryPrograms_insert;
GO


CREATE PROCEDURE sp_RecoveryPrograms_insert
	@UserID				INT,
	@RecoveryTypeID			INT,
	@ProgramName			VARCHAR(50),
	@StartDate			DATETIME,
	@EndDate			DATETIME,
	@SoberDate			DATETIME
AS
	
	INSERT INTO RecoveryPrograms
		(UserID, RecoveryTypeID, ProgramName, start_dt, end_dt, sober_dt)
	VALUES
		(@UserID, @RecoveryTypeID, @ProgramName, @StartDate, @EndDate, @SoberDate);

	SELECT @@IDENTITY;

GO

--EXEC sp_RecoveryPrograms_insert 1001