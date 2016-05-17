IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sugar_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_Sugar_UserID_get;
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Sugar_UserID_get]
	@UserID			INT,
	@StartDate		DATETIME,
	@EndDate		DATETIME
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT
		SugarID,
		Sugar
	FROM
		Sugar
	WHERE
		UserID = @UserID AND
		SugarDateTime BETWEEN @StartDate AND @EndDate
	ORDER BY
		SugarDateTime
	
		
END



GO

