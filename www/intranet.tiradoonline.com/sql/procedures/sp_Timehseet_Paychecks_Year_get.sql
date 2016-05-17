IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Timehseet_Paychecks_Year_get' AND TYPE = 'P')
DROP PROCEDURE sp_Timehseet_Paychecks_Year_get;
GO



CREATE PROCEDURE [dbo].[sp_Timehseet_Paychecks_Year_get]
	@UserID				INT,
	@CurrentYear			INT
AS
	
	SELECT 
		b.TimesheetCompanyName,
		a.* 
	FROM
		Paychecks a,
		TimesheetCompany b
	WHERE
		a.TimesheetCompanyID = b.TimesheetCompanyID
		AND b.UserID = @UserID
		AND DATEPART(year, a.PaymentDate) = @CurrentYear
	ORDER BY
		a.PaymentDate;



GO

