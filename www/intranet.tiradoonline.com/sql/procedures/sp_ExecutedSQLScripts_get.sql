IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ExecutedSQLScripts_get' AND TYPE = 'P')
DROP PROCEDURE sp_ExecutedSQLScripts_get;
GO




CREATE PROCEDURE [dbo].[sp_ExecutedSQLScripts_get]
AS
	
	SELECT TOP 50
		create_dt AS Time,
		ApplicationName AS Application,
		ExecutedSQLScript AS SQL
	FROM
		ExecutedSQLScripts
	ORDER BY
		create_dt 
	DESC;



GO

