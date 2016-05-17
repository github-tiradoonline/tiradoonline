IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timesheet_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Timesheet_insert;
GO




CREATE PROCEDURE [dbo].[sp_Timesheet_insert]
	@TimesheetCompanyID		INT,
	@TimesheetTypeID		INT,
	@TimesheetInvoiceDate		DATETIME,
	@TimesheetInvoiceNumber		VARCHAR(100),
	@TimesheetHourlyRate		NUMERIC(9, 2),
	@TimesheetStartDate		DATETIME,
	@TimesheetEndDate		DATETIME
AS
	
	INSERT INTO Timesheet 
		(TimesheetCompanyID, TimesheetTypeID, TimesheetInvoiceDate, TimesheetInvoiceNumber, TimesheetHourlyRate, TimesheetStartDate, TimesheetEndDate)
	VALUES
		(@TimesheetCompanyID, @TimesheetTypeID, @TimesheetInvoiceDate, @TimesheetInvoiceNumber, @TimesheetHourlyRate, @TimesheetStartDate, @TimesheetEndDate);

	SELECT @@IDENTITY;




GO

