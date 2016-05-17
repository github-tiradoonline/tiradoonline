IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MonthlyBills_delete' AND TYPE = 'P')
DROP PROCEDURE sp_MonthlyBills_delete;
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MonthlyBills_delete]
	@MonthlyBillID			INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM MonthlyBills WHERE
		MonthlyBillID = @MonthlyBillID;
END


GO

