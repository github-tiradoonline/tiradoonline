IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timesheet_Invoices_get' AND TYPE = 'P')
DROP PROCEDURE sp_Timesheet_Invoices_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Timesheet_Invoices_get]
	@TimesheetCompanyID		INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	SELECT 
		TimesheetCompanyName = (SELECT TimesheetCompanyName FROM TimesheetCompany WHERE TimesheetCompanyID = @TimesheetCompanyID), 
		TotalPay = (SELECT SUM(TimesheetHours) * Timesheet.TimeSheetHourlyRate FROM TimesheetDetail WHERE TimesheetID = TimeSheet.TimeSheetID),
		* 
	FROM 
		TimeSheet 
	WHERE 
		TimesheetCompanyID = @TimesheetCompanyID 
	ORDER BY 
		TimesheetStartDate		
END



GO

