IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCoverLetter_insert' AND TYPE = 'P')
DROP PROCEDURE sp_JobCoverLetter_insert;
GO




CREATE PROCEDURE [dbo].[sp_JobCoverLetter_insert]
	@UserID				INT,
	@JobCoverLetterName		VARCHAR(100),
	@JobCoverLetterText		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobCoverLetter 
		(UserID, JobCoverLetterName, JobCoverLetterText)
	VALUES
		(@UserID, @JobCoverLetterName, @JobCoverLetterText);


	SELECT @@IDENTITY;


GO

