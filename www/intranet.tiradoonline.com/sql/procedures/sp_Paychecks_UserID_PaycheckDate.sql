IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Paychecks_UserID_PaycheckDate' AND TYPE = 'P')
DROP PROCEDURE sp_Paychecks_UserID_PaycheckDate;
GO


CREATE PROCEDURE [dbo].[sp_Paychecks_UserID_PaycheckDate]
	@UserID			INT,
	@PaycheckDate		SMALLDATETIME
AS
	SELECT 
		a.PaycheckID,
		a.PaymentDate AS PaycheckDate, 
		a.Gross
	FROM 
		Paychecks a,
		Companies b
	WHERE 
		a.TimesheetCompanyID = b.CompanyID AND
		b.UserID = @UserID AND
		DATEPART(month, a.PaymentDate) = MONTH(@PaycheckDate) AND
		DATEPART(year, a.PaymentDate) = YEAR(@PaycheckDate) 
	ORDER BY 
		a.PaymentDate


GO

