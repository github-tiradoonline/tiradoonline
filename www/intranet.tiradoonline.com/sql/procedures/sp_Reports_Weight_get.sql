IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Reports_Weight_get' AND TYPE = 'P')
DROP PROCEDURE sp_Reports_Weight_get;
GO




CREATE PROCEDURE [dbo].[sp_Reports_Weight_get]
	@UserID				INT
AS


	SELECT TOP 20
		WeightDateTime = CONVERT(VARCHAR, CONVERT(DATE, WeightDateTime)),
		Weight
	FROM
		Weight
	WHERE
		UserID = @UserID
	ORDER BY
		WeightDateTime;
	


GO

