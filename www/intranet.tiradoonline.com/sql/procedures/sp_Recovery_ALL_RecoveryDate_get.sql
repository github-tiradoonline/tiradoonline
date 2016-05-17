IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Recovery_ALL_RecoveryDate_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Recovery_ALL_RecoveryDate_get;
GO

CREATE PROCEDURE sp_Recovery_ALL_RecoveryDate_get
	@UserID				INT,
	@RecoveryDate			SMALLDATETIME
AS

	SELECT DISTINCT 
		RecoveryDate = CONVERT(DATE, c.RecoveryGroupSessionDateTime),
		ProgamName = a.ProgramName + ' (' + CONVERT(VARCHAR, COUNT(*)) + ')'
	FROM 
		RecoveryPrograms a,
		RecoveryGroups b,
		RecoveryGroupSessions c
	WHERE
		a.RecoveryProgramID = b.RecoveryProgramID
		AND b.RecoveryGroupID = c.RecoveryGroupID
		AND a.UserID = @UserID
		AND DATEPART(month, c.RecoveryGroupSessionDateTime) = MONTH(@RecoveryDate)
		AND DATEPART(year, c.RecoveryGroupSessionDateTime) = YEAR(@RecoveryDate)
	GROUP BY
		CONVERT(DATE, c.RecoveryGroupSessionDateTime),
		a.ProgramName


GO
EXEC sp_Recovery_ALL_RecoveryDate_get 1001, '5/1/15'