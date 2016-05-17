IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_ResumeAnonymous_insert' AND TYPE = 'P')
	DROP PROCEDURE sp_ResumeAnonymous_insert;
GO

CREATE PROCEDURE sp_ResumeAnonymous_insert
	@SessionID			VARCHAR(100),
	@IPAddress			VARCHAR(100),
	@Browser			VARCHAR(500),
	@Referer			VARCHAR(500),
    	@ResumeFile			VARCHAR(50)
AS
	
	INSERT INTO ResumeAnonymous
		(SessionID, IPAddress, Browser, Referer, ResumeFile)
	VALUES
		(@SessionID, @IPAddress, @Browser, @Referer, @ResumeFile)



GO

