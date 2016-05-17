IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Paychecks_CompanyID' AND TYPE = 'P')
DROP PROCEDURE sp_Paychecks_CompanyID;
GO


CREATE PROCEDURE [dbo].[sp_Paychecks_CompanyID]
	@TimesheetCompanyID		INT,
	@PaymentYear		INT
AS
	SELECT 
		Gross = SUM(Gross), 
		Federal = SUM(Federal), 
		SocialSecurity = SUM(SocialSecurity), 
		Medicare = SUM(Medicare), 
		NY_Withholding = SUM(NY_Withholding), 
		NY_Disability = SUM(NY_Disability), 
		NY_City = SUM(NY_City) 
	FROM 
		Paychecks 
	WHERE 
		TimesheetCompanyID = @TimesheetCompanyID AND
		DATEPART(YEAR, PaymentDate) = @PaymentYear


GO

