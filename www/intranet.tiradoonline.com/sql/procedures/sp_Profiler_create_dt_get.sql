IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Profiler_create_dt_get' AND TYPE = 'P')
DROP PROCEDURE sp_Profiler_create_dt_get;
GO




CREATE PROCEDURE [dbo].[sp_Profiler_create_dt_get]
	@create_dt	SMALLDATETIME
AS

	SELECT
		TOP 100 *
	FROM 
		ExecutedSQLScripts 
	WHERE
		DATEPART(day, create_dt) = DATEPART(day, @create_dt) AND
		DATEPART(month, create_dt) = DATEPART(month, @create_dt) AND
		DATEPART(year, create_dt) = DATEPART(year, @create_dt)
	ORDER BY 
		create_dt DESC




GO

