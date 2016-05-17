IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sugar_report' AND TYPE = 'P')
	DROP PROCEDURE sp_Sugar_report;
GO


CREATE PROCEDURE sp_Sugar_report
	@UserID				INT,
	@StartDate			DATETIME,
	@EndDate			DATETIME
AS
	
	SELECT 
		MaxSugar = (SELECT MAX(Sugar) FROM Sugar WHERE SugarDateTime >= @StartDate AND SugarDateTime <= @EndDate AND UserID = @UserID), 
		MinSugar = (SELECT MIN(Sugar) FROM Sugar WHERE SugarDateTime >= @StartDate AND SugarDateTime <= @EndDate AND UserID = @UserID), 
		SugarDateTime, 
		Sugar 
	FROM 
		Sugar
	WHERE 
		SugarDateTime >= @StartDate 
		AND SugarDateTime <= @EndDate 
		AND UserID = @UserID 
	ORDER BY 
		SugarDateTime DESC;

GO

EXEC sp_Sugar_report 1001, '3/1/15', '3/31/15'