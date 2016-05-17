IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reports_Sugar_get' AND TYPE = 'P')
DROP PROCEDURE sp_Reports_Sugar_get;
GO




CREATE PROCEDURE [dbo].[sp_Reports_Sugar_get]
	@UserID				INT,
	@StartDate			DATETIME,
	@EndDate			DATETIME
AS


	SELECT
		SugarDateTime = CONVERT(VARCHAR, CONVERT(DATE, SugarDateTime)),
		Sugar
	FROM
		Sugar
	WHERE
		UserID = @UserID
		AND SugarDateTime BETWEEN @StartDate AND @EndDate
	ORDER BY
		SugarDateTime;
	


GO

