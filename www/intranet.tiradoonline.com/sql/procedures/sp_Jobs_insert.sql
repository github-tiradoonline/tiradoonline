IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Jobs_insert' AND TYPE = 'P')
DROP PROCEDURE sp_Jobs_insert;
GO



CREATE PROCEDURE [dbo].[sp_Jobs_insert]
	@JobCompanyID			INT, 
	@JobCompanyContactID		INT, 
	@JobSalaryTypeID		INT,
	@JobDate			DATETIME, 
	@JobPosition			VARCHAR(500), 
	@JobSalary			NUMERIC(9,2),
	@JobClient			VARCHAR(100),
	@JobCity			VARCHAR(30),
	@JobStateID			INT,
	@JobRequirements		VARCHAR(MAX), 	
	@JobNotes			VARCHAR(MAX)
AS
	
	BEGIN TRANSACTION transJobsInsert

		INSERT INTO Jobs
			(JobCompanyID, JobCompanyContactID, JobSalaryTypeID, JobDate, JobPosition, JobSalary, JobClient, JobCity, JobStateID, JobRequirements, JobNotes)
		VALUES
			(@JobCompanyID, @JobCompanyContactID, @JobSalaryTypeID, @JobDate, @JobPosition, @JobSalary, @JobClient, @JobCity, @JobStateID, @JobRequirements, @JobNotes);

		DECLARE @JobID 		INT;
		SET @JobID = @@IDENTITY;

		INSERT INTO JobQueue
			(JobID)
		VALUES
			(@JobID);

		SELECT @JobID;

	IF @@ERROR <> 0 
		ROLLBACK TRANSACTION transJobsInsert;
	ELSE
		COMMIT TRANSACTION transJobsInsert;



GO

