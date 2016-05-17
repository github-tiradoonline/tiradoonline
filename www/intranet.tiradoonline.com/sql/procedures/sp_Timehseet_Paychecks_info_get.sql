IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timehseet_Paychecks_info_get' AND TYPE = 'P')
DROP PROCEDURE sp_Timehseet_Paychecks_info_get;
GO



CREATE PROCEDURE [dbo].[sp_Timehseet_Paychecks_info_get]
	@TimeSheetCompanyID			INT = NULL
AS
	
	SELECT 
		TimesheetCompanyName = (SELECT TimesheetCompanyName FROM TimesheetCompany WHERE TimesheetCompanyID = @TimesheetCompanyID),
		TotalPaychecks = (SELECT COUNT(*) FROM Paychecks WHERE TimesheetCompanyID = @TimesheetCompanyID),
		MinPaycheckYear = (SELECT MIN(DATEPART(YEAR, PaymentDate)) FROM Paychecks),
		MaxPaycheckYear = (SELECT MAX(DATEPART(YEAR, PaymentDate)) FROM Paychecks)



GO

