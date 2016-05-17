IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_MediaType_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_MediaType_delete;
GO

CREATE PROCEDURE sp_MediaFile_MediaType_delete
	@UserID			INT,
	@MediaFileType		VARCHAR(100)
AS
	
	DELETE FROM MediaFile WHERE 
		UserID = @UserID 
		AND UPPER(MediaFileType) = UPPER(@MediaFileType);


GO

exec sp_MediaFile_MediaType_delete 1001, 'MUSIC';