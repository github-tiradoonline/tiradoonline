IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobInterview_insert' AND TYPE = 'P')
DROP PROCEDURE sp_JobInterview_insert;
GO




CREATE PROCEDURE [dbo].[sp_JobInterview_insert]
	@JobCompanyID			INT,
	@JobInterviewTypeID		INT,
	@JobInterviewDateTime		DATETIME,
	@JobInterviewClientID		INT,
	@JobInterviewClientContactID	INT,
	@JobInterviewAddress1		VARCHAR(50),
	@JobInterviewAddress2		VARCHAR(50),
	@JobInterviewCity		VARCHAR(50),
	@StateID			INT,
	@JobInterviewZipCode		VARCHAR(20),
	@JobInterviewNotes		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobInterview 
		(JobCompanyID, JobInterviewTypeID, JobInterviewDateTime, JobInterviewClientID, JobInterviewClientContactID, JobInterviewAddress1, JobInterviewAddress2, JobInterviewCity, StateID, JobInterviewZipCode, JobInterviewNotes) 
	VALUES
		(@JobCompanyID, @JobInterviewTypeID, @JobInterviewDateTime, @JobInterviewClientID, @JobInterviewClientContactID, @JobInterviewAddress1, @JobInterviewAddress2, @JobInterviewCity, @StateID, @JobInterviewZipCode, @JobInterviewNotes) 

	SELECT @@IDENTITY;


GO

