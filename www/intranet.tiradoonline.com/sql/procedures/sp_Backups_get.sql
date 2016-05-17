IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Backups_get' AND TYPE = 'P')
DROP PROCEDURE sp_Backups_get;
GO


CREATE PROCEDURE [dbo].[sp_Backups_get]
	@UserID			INT
AS
	DECLARE @MediaSetID	INT;
	SET @MediaSetID = (SELECT MAX(media_set_id) FROM MSDB..backupmediafamily WHERE logical_device_name = 'teddy_dmp');
	--PRINT @MediaSetID;

	SELECT 
		c.backup_finish_date AS BackupDate
	FROM
		MSDB..backupmediaset b,
		MSDB..backupset c
	WHERE 
		b.media_set_id = @MediaSetID AND
		b.media_set_id = c.media_set_id and
		c.user_name = user_name(@UserID)
	GROUP BY
		c.media_set_id, c.backup_finish_date 
	ORDER BY
		c.backup_finish_date DESC






GO

