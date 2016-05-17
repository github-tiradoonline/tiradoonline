IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_MediaFileName_get' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_MediaFileName_get;
GO

CREATE PROCEDURE sp_MediaFile_MediaFileName_get
	@UserID				INT,
	@MediaFileName			VARCHAR(100)
AS
	
	SELECT 
		*
	FROM 
		MediaFile 
	WHERE  
		UserID = @UserID
		AND UPPER(MediaFileName) = UPPER(@MediaFileName)
	ORDER BY 
		MediaFileDirectory;


GO

EXEC sp_MediaFile_MediaFileName_get 1001, 'mUSIC'