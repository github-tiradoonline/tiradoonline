IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timehseet_Paychecks_CompanyID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Timehseet_Paychecks_CompanyID_get;
GO



CREATE PROCEDURE [dbo].[sp_Timehseet_Paychecks_CompanyID_get]
	@TimeSheetCompanyID			INT
AS
	
	SELECT 
		PaycheckID,
		PaymentDate,
		Net = (Gross - 
			Federal - 
			SocialSecurity -
			Medicare - 
			NY_Withholding -
			NY_Disability - 
			NY_City)
			
	FROM 		
			
		Paychecks
	WHERE 
		TimeSheetCompanyID = @TimeSheetCompanyID
	ORDER BY 
		PaymentDate;



GO

