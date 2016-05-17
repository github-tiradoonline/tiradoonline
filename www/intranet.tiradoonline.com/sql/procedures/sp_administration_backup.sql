IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_administration_backup' AND TYPE = 'P')
DROP PROCEDURE sp_administration_backup;
GO


CREATE PROCEDURE [dbo].[sp_administration_backup]
	@UserID	INT
AS
	BEGIN
		BACKUP DATABASE teddy TO teddy_dmp;
		BACKUP LOG teddy TO teddy_dmp;
		INSERT INTO Backups (UserID) VALUES (@UserID);
	END




GO

