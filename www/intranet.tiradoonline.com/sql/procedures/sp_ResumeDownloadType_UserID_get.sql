IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ResumeDownloadType_UserID_get' AND TYPE = 'P')
DROP PROCEDURE sp_ResumeDownloadType_UserID_get;
GO




CREATE PROCEDURE [dbo].[sp_ResumeDownloadType_UserID_get]
	@UserID			INT
AS
	
	
	SELECT 
		ResumeDownloadTypeID, 
		ResumeDownloadTypeName,
		ResumeDownloadTypeFileName
	FROM 
		ResumeDownloadType
	WHERE 
		UserID = @UserID 
	ORDER BY 
		 create_dt;


GO

