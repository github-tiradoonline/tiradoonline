IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_MediaFile_UserID_search' AND TYPE = 'P')
	DROP PROCEDURE sp_MediaFile_UserID_search;
GO

CREATE PROCEDURE sp_MediaFile_UserID_search
	@UserID			INT,
	@SearchString		VARCHAR(100),
	@MediaFileExt		VARCHAR(100) = NULL
AS
	
	SET @SearchString = '%' + @SearchString + '%';
	
	IF @MediaFileExt IS NOT NULL
		BEGIN
			SELECT 
				*
			FROM 
				MediaFile 
			WHERE  
				UserID = @UserID 
				AND LOWER(MediaFileName) LIKE LOWER(@SearchString)
				AND LOWER(MediaFileExt) = LOWER(@MediaFileExt)
			ORDER BY 
				MediaFileName;
		END
	ELSE
		BEGIN
			SELECT 
				*
			FROM 
				MediaFile 
			WHERE  
				UserID = @UserID 
				AND LOWER(MediaFileName) LIKE LOWER(@SearchString)
			ORDER BY 
				MediaFileName;
		END

GO

EXEC sp_MediaFile_UserID_search 1001, 'madonna', '.mp3'