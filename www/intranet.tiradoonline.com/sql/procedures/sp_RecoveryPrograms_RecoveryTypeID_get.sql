IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_RecoveryPrograms_RecoveryTypeID_get' AND TYPE = 'P')
DROP PROCEDURE sp_RecoveryPrograms_RecoveryTypeID_get;
GO


CREATE PROCEDURE [dbo].[sp_RecoveryPrograms_RecoveryTypeID_get]
	@RecoveryTypeID		INT
AS
	SELECT 
		RecoveryProgramID,
		StartDate = start_dt,
		EndDate = end_dt,
		ProgramName
	FROM 
		RecoveryPrograms
	WHERE
		RecoveryTypeID = @RecoveryTypeID;


GO

EXEC sp_RecoveryPrograms_RecoveryTypeID_get 1001