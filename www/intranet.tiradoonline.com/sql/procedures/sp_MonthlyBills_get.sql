IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MonthlyBills_get' AND TYPE = 'P')
DROP PROCEDURE sp_MonthlyBills_get;
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_get]
	@BankingAccountID		INT,
	@MonthlyBillID			INT = NULL
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @MonthlyBillID IS NULL
		BEGIN
			SELECT * FROM MonthlyBills WHERE BankingAccountID = @BankingAccountID ORDER BY MonthlyBillDate
		END
	ELSE
		SELECT * FROM MonthlyBills WHERE MonthlyBillID = @MonthlyBillID
		-- Insert statements for procedure here
END


GO

