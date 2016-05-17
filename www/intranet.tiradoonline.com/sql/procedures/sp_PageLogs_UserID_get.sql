IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_PageLogs_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_PageLogs_UserID_get;
GO


CREATE PROCEDURE [dbo].[sp_PageLogs_UserID_get]
AS

	DECLARE @create_dt 	DATETIME
	SET @create_dt = GETDATE();

	SELECT 
		UserID = '',
		FullName = 'ALL USERS'
	UNION 
	SELECT
		DISTINCT (a.UserID),
		FullName = b.FirstName + ' ' + b.LastName
	FROM
		PageLogs a,
		Users b
	WHERE
		a.UserID = b.UserID AND
		DATEPART(month, a.create_dt) = DATEPART(month, @create_dt) AND
		DATEPART(day, a.create_dt) = DATEPART(day, @create_dt) AND 
		DATEPART(year, a.create_dt) = DATEPART(year, @create_dt)



GO

