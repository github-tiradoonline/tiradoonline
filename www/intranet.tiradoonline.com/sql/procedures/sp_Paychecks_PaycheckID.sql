IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Paychecks_PaycheckID' AND TYPE = 'P')
DROP PROCEDURE sp_Paychecks_PaycheckID;
GO


CREATE PROCEDURE [dbo].[sp_Paychecks_PaycheckID]
	@PaycheckID		INT 
AS
	SELECT 
		TimesheetCompanyID, 
		PaymentDate, 
		HourlyRate, 
		Gross, 
		Federal, 
		SocialSecurity, 
		Medicare, 
		NY_Withholding, 
		NY_Disability, 
		NY_City 
	FROM 
		Paychecks 
	WHERE 
		PaycheckID = @PaycheckID


GO

