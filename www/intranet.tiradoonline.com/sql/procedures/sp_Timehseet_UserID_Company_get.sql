IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timehseet_TimesheetID_Total_get' AND TYPE = 'P')
	DROP PROCEDURE sp_Timehseet_TimesheetID_Total_get;
GO

CREATE PROCEDURE sp_Timehseet_TimesheetID_Total_get
	@TimesheetID			INT
AS
	
	SELECT 
		SUM
	FROM 
		Timesheet a,
		TimesheetDetail b
	WHERE
		a.TimesheetID = b.TimesheetID
		AND a.TimesheetID = @TimesheetID;

GO

EXEC sp_Timehseet_TimesheetID_Total_get @TimesheetID