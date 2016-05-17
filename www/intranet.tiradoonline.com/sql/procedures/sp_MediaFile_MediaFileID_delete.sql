IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_MediaFileID_delete' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_MediaFileID_delete;
GO

CREATE PROCEDURE sp_MediaFile_MediaFileID_delete
	@MediaFileID			VARCHAR(100)
AS
	
	DELETE FROM MediaFile WHERE MediaFileID = @MediaFileID;


GO

--EXEC sp_MediaFile_MediaFileID_delete 1001