IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Accounts_AccountID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Accounts_AccountID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Accounts_AccountID_get]
	@Accountid				INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT * FROM Accounts WHERE Accountid = @Accountid;

END



GO

