IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Paychecks_UserID' AND TYPE = 'P')
DROP PROCEDURE sp_Paychecks_UserID;
GO


CREATE PROCEDURE [dbo].[sp_Paychecks_UserID]
	@UserID			INT,
	@PaymentYear		INT 
AS
	SELECT 
		b.PaycheckID, 
		b.PaymentDate, 
		b.TimesheetCompanyID, 
		a.CompanyName, 
		Gross, 
		Net = (b.Gross - (b.Federal + b.SocialSecurity + b.Medicare + b.NY_Withholding + b.NY_Disability + b.NY_City)), 
                HourlyRate, 
                Hours = (Gross / HourlyRate),
                TotalRecords = (SELECT COUNT(*) FROM Companies a, Paychecks b WHERE a.CompanyID = b.TimesheetCompanyID AND a.UserID = @UserID AND DATEPART(year, b.PaymentDate) = @PaymentYear) 
	FROM 
		Companies a, 
		Paychecks b 
	WHERE 
		a.CompanyID = b.TimesheetCompanyID AND 
		a.UserID = @UserID AND 
		DATEPART(year, b.PaymentDate) = @PaymentYear 
	ORDER BY  
		b.PaymentDate DESC, 
		b.TimesheetCompanyID


GO

