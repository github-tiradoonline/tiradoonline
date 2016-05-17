IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ResumeDownloads_get' AND TYPE = 'P')
DROP PROCEDURE sp_ResumeDownloads_get;
GO



CREATE PROCEDURE [dbo].[sp_ResumeDownloads_get]
	@ResumeDownloadID		INT = NULL
AS


	IF @ResumeDownloadID IS NULL
		BEGIN
			SELECT
				a.*,
				ReferencedBy = (SELECT ReferencedByName FROM ReferencedBy WHERE ReferencedByID = a.ReferencedByID),
				ResumeDownloadType = (SELECT ResumeDownloadTypeName FROM ResumeDownloadType WHERE ResumeDownloadTypeID = a.ResumeDownloadTypeID)
			FROM
				ResumeDownloads a
			ORDER BY
				a.create_dt DESC;
		END
	ELSE
		BEGIN
			SELECT
				*
			FROM
				ResumeDownloads	
			WHERE
				ResumeDownloadID = @ResumeDownloadID;
		END


GO

