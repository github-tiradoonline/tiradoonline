IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PageLogs_create_dt_get' AND TYPE = 'P')
DROP PROCEDURE sp_PageLogs_create_dt_get;
GO


CREATE PROCEDURE [dbo].[sp_PageLogs_create_dt_get]
	@create_dt	DATETIME = GETDATE,
	@UserID	INT = NULL
AS

	DECLARE @SQL	NVARCHAR(1000);

	SET @SQL = '';
	SET @SQL = @SQL + 'SELECT ';
	SET @SQL = @SQL + 'TOP 100 ';
	SET @SQL = @SQL + 'a.PageLogID, ';
	SET @SQL = @SQL + 'a.Template, ';
	SET @SQL = @SQL + 'a.Action, ';
	SET @SQL = @SQL + 'a.QUERY_STRING, ';
	SET @SQL = @SQL + 'a.FORM, ';
	SET @SQL = @SQL + 'FullName = b.FirstName + '' '' + b.LastName, ';
	SET @SQL = @SQL + 'a.SCRIPT_NAME, ';
	SET @SQL = @SQL + 'a.create_dt ';
	SET @SQL = @SQL + 'FROM ';
	SET @SQL = @SQL + 'PageLogs a, ';
	SET @SQL = @SQL + 'Users b ';
	SET @SQL = @SQL + 'WHERE ';
	SET @SQL = @SQL + 'a.UserID = b.UserID AND ';
	SET @SQL = @SQL + 'DATEPART(month, a.create_dt) = DATEPART(month, ''' + CONVERT(VARCHAR, @create_dt) + ''') AND ';
	SET @SQL = @SQL + 'DATEPART(day, a.create_dt) = DATEPART(day, ''' + CONVERT(VARCHAR, @create_dt) + ''') AND '; 
	SET @SQL = @SQL + 'DATEPART(year, a.create_dt) = DATEPART(year, ''' + CONVERT(VARCHAR, @create_dt) + ''') ';
	SET @SQL = @SQL + 'ORDER BY ';
	SET @SQL = @SQL + 'a.create_dt DESC';
	
	--print @SQL;

	--EXEC(@SQL);

	SELECT TOP 100 
		a.PageLogID, 
		a.Template, 
		a.Action, 
		a.QUERY_STRING, 
		a.FORM, 
		FullName = b.FirstName + ' ' + b.LastName, 
		CONVERT(VARCHAR, a.SCRIPT_NAME) AS PageName, 
		a.create_dt 
	FROM 
		PageLogs a, 
		Users b 
	WHERE 
		a.UserID = b.UserID AND 
		--a.create_dt = @create_dt
		DATEPART(month, a.create_dt) = DATEPART(month, @create_dt) AND 
		DATEPART(day, a.create_dt) = DATEPART(day, @create_dt) AND 
		DATEPART(year, a.create_dt) = DATEPART(year, @create_dt) 
	ORDER BY 
		a.create_dt DESC;



GO

