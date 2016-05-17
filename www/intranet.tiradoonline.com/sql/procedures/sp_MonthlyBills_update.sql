IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MonthlyBills_update' AND TYPE = 'P')
DROP PROCEDURE sp_MonthlyBills_update;
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_update]
	@MonthlyBillID			INT,
	@MonthlyBillStartDate	SMALLDATETIME,
	@MonthlyBillDate		SMALLDATETIME,
	@MonthlyBillDesc		VARCHAR(100),
	@MonthlyBillAmount		NUMERIC(9,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE MonthlyBills SET
		MonthlyBillStartDate = @MonthlyBillStartDate,
		MonthlyBillDate = @MonthlyBillDate,
		MonthlyBillDesc = @MonthlyBillDesc,
		MonthlyBillAmount = @MonthlyBillAmount
	WHERE
		MonthlyBillID = @MonthlyBillID;
END


GO

