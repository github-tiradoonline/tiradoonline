IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timesheet_TimesheetID_TimesheetHTML_update' AND TYPE = 'P')
DROP PROCEDURE sp_Timesheet_TimesheetID_TimesheetHTML_update;
GO



CREATE PROCEDURE sp_Timesheet_TimesheetID_TimesheetHTML_update 
	@TimesheetID				INT,
	@TimesheetHTML 				VARCHAR(MAX)
AS
	
	UPDATE Timesheet SET
		TimesheetHTML = @TimesheetHTML
	WHERE
		TimesheetID = @TimesheetID;


GO

