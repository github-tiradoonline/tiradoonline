IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Banking_get_sum' AND TYPE = 'P')
DROP PROCEDURE sp_Banking_get_sum;
GO


CREATE PROCEDURE [dbo].[sp_Banking_get_sum]
	@UserID 	INT
AS
	DECLARE @TotalBanking	INT
	DECLARE @TotalGross	INT
        DECLARE @TotalNet       INT

	SET @TotalBanking = (SELECT ISNULL(SUM(b.Payment), 0) TotalBanking FROM BankingAccount a, Banking b WHERE a.UserID = @UserID AND a.BankingAccountID = b.BankingAccountID)
	
	SET @TotalNet = (SELECT SUM(a.Gross) - SUM(a.Federal + a.SocialSecurity + a.Medicare + a.NY_Withholding + a.NY_Disability + a.NY_City) FROM Paychecks a, Companies b WHERE a.TimesheetCompanyID = b.CompanyID AND DATEPART(year, a.PaymentDate) = DATEPART(year, getdate()) AND b.UserID = @UserID)

	SELECT 
             @TotalBanking TotalBanking, 
             @TotalGross TotalGross,
             @TotalNet TotalNet



GO

