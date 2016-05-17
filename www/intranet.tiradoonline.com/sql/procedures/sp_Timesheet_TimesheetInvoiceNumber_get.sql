IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timesheet_TimesheetInvoiceNumber_get' AND TYPE = 'P')
DROP PROCEDURE sp_Timesheet_TimesheetInvoiceNumber_get;
GO




CREATE PROCEDURE [dbo].[sp_Timesheet_TimesheetInvoiceNumber_get]
	@TimesheetCompanyID	INT
AS

	SELECT 
		TimeSheetInvoiceNumber = ISNULL(MAX(TimeSheetInvoiceNumber) + 1, 1001) 
	FROM 
		TimeSheet 
	WHERE 
		TimeSheetCompanyID = @TimesheetCompanyID;



GO

