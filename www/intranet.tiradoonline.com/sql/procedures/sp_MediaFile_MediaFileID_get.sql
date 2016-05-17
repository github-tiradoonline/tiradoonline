IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_MediaFileID_get' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_MediaFileID_get;
GO

CREATE PROCEDURE sp_MediaFile_MediaFileID_get
	@MediaFileID			VARCHAR(100)
AS
	
	SELECT 
		*
	FROM 
		MediaFile 
	WHERE  
		MediaFileID = @MediaFileID;


GO

EXEC sp_MediaFile_MediaFileID_get 1001