IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MonthlyBills_insert' AND TYPE = 'P')
DROP PROCEDURE sp_MonthlyBills_insert;
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_insert]
	@BankingAccountID		INT,
	@MonthlyBillStartDate		SMALLDATETIME,
	@MonthlyBillDate		SMALLDATETIME,
	@MonthlyBillDesc		VARCHAR(100),
	@MonthlyBillAmount		NUMERIC(9,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO MonthlyBills
		(BankingAccountID, MonthlyBillStartDate, MonthlyBillDate, MonthlyBillDesc, MonthlyBillAmount)
	VALUES
		(@BankingAccountID, @MonthlyBillStartDate, @MonthlyBillDate, @MonthlyBillDesc, @MonthlyBillAmount)
		
END


GO

