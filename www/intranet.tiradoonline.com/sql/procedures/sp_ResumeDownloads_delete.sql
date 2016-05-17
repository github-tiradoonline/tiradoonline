IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ResumeDownloads_delete' AND TYPE = 'P')
DROP PROCEDURE sp_ResumeDownloads_delete;
GO



CREATE PROCEDURE [dbo].[sp_ResumeDownloads_delete]
	@ResumeDownloadID		INT
AS

	DELETE FROM ResumeDownloads WHERE ResumeDownloadID = @ResumeDownloadID;



GO

