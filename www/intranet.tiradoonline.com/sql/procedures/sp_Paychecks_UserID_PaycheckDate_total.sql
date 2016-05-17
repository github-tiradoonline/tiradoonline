IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Paychecks_UserID_PaycheckDate_total' AND TYPE = 'P')
DROP PROCEDURE sp_Paychecks_UserID_PaycheckDate_total;
GO


CREATE PROCEDURE [dbo].[sp_Paychecks_UserID_PaycheckDate_total]
	@UserID			INT,
	@PaymentYear		INT
AS
	SELECT 
		Gross = SUM(a.Gross), 
		Federal = SUM(a.Federal), 
		SocialSecurity = SUM(a.SocialSecurity), 
		Medicare = SUM(a.Medicare), 
		NY_Withholding = SUM(a.NY_Withholding), 
		NY_Disability = SUM(a.NY_Disability), 
		NY_City = SUM(a.NY_City) 
	FROM 
		Paychecks a,
		Companies b
	WHERE 
		a.TimesheetCompanyID = b.CompanyID AND
		b.UserID = @UserID AND
		DATEPART(YEAR, PaymentDate) = @PaymentYear


GO

