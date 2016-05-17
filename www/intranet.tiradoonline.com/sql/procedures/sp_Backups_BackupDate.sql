IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Backups_BackupDate' AND TYPE = 'P')
DROP PROCEDURE sp_Backups_BackupDate;
GO


CREATE PROCEDURE [dbo].[sp_Backups_BackupDate]
	@BackupDate		SMALLDATETIME
AS

	SELECT
		a.BackupDate, b.UserName
	FROM
		Backups a, Users b
	WHERE 
		a.UserID = b.UserID AND
		DATEPART(day, a.BackupDate) = DAY(@BackupDate) AND
		DATEPART(month, a.BackupDate) = MONTH(@BackupDate) AND
		DATEPART(year, a.BackupDate) = YEAR(@BackupDate)
	ORDER BY 
		a.BackupDate DESC


GO

