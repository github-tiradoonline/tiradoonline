IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_Duplicates_get' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_Duplicates_get;
GO

CREATE PROCEDURE sp_MediaFile_Duplicates_get
	@UserID				INT,
	@MediaFileType			VARCHAR(100)
AS
	
	SELECT 
		DISTINCT UserID,
		MediaFileName, 
		Duplicates = COUNT(*) 
	FROM 
		MediaFile 
	WHERE  
		UserID = @UserID
		AND UPPER(MediaFileType) = UPPER(@MediaFileType)
	GROUP BY 
		UserID,
		MediaFileName 
	HAVING 
		COUNT(*) > 1 
	ORDER BY 
		COUNT(*) DESC,
		MediaFileName;


GO

EXEC sp_MediaFile_Duplicates_get 1002, 'mUSIC'