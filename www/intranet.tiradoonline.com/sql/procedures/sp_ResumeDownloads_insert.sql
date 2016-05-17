IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ResumeDownloads_insert' AND TYPE = 'P')
DROP PROCEDURE sp_ResumeDownloads_insert;
GO



CREATE PROCEDURE sp_ResumeDownloads_insert
	@FullName			VARCHAR(50),
    	@Company			VARCHAR(50),
	@Phone				VARCHAR(50),
    	@Email				VARCHAR(50),
    	@Comments			VARCHAR(1000),
    	@Website			VARCHAR(100),
	@ReferencedByID			INT,
    	@ResumeDownloadTypeID		INT,
    	@Referer			VARCHAR(1000),
	@SessionID			VARCHAR(100)
AS
	
	DECLARE @ResumeDownloadID		INT;
	
	SELECT @ResumeDownloadID = MAX(ResumeDownloadID) FROM ResumeDownloads;

	INSERT INTO ResumeDownloads
		(FullName, Company, Phone, Email, Comments, Website, ReferencedByID, ResumeDownloadTypeID, Referer, SessionID)
	VALUES
		(@FullName, @Company, @Phone, @Email, @Comments, @Website, @ReferencedByID, @ResumeDownloadTypeID, @Referer, @SessionID);

	SELECT ResumeDownloadTypeFileName FROM ResumeDownloadType WHERE ResumeDownloadTypeID = @ResumeDownloadTypeID;



GO

