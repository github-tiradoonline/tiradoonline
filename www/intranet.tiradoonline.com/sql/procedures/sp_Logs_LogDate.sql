IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Logs_LogDate' AND TYPE = 'P')
DROP PROCEDURE sp_Logs_LogDate;
GO


CREATE PROCEDURE [dbo].[sp_Logs_LogDate]
	@LogDate		SMALLDATETIME
AS
	SELECT
		LogDate = create_dt, LogDesc
	FROM
		Logs
	WHERE 
		DATEPART(day, create_dt) = DAY(@LogDate) AND
		DATEPART(month, create_dt) = MONTH(@LogDate) AND
		DATEPART(year, create_dt) = YEAR(@LogDate)
	ORDER BY 
		create_dt DESC


GO

