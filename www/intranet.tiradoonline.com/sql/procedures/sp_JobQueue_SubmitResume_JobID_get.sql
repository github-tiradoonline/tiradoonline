IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobQueue_SubmitResume_JobID_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobQueue_SubmitResume_JobID_get;
GO



CREATE PROCEDURE [dbo].[sp_JobQueue_SubmitResume_JobID_get]
	@JobID				INT
AS

	SELECT
		b.JobPosition,
		JobCompanyContactName = 
			CASE 
				WHEN c.JobCompanyContactFirstName <> '' AND c.JobCompanyContactLastName = '' THEN
					c.JobCompanyContactFirstName
				WHEN c.JobCompanyContactFirstName = '' AND c.JobCompanyContactLastName <> '' THEN
					c.JobCompanyContactLastName
				ELSE
					c.JobCompanyContactLastName + ', ' + c.JobCompanyContactFirstName
			END,
		c.JobCompanyContactEmail
	FROM
		JobQueue a,
		Jobs b,
		JobCompanyContact c
	WHERE
		a.JobID = b.JobID
		AND a.JobID = @JobID
		AND b.JobCompanyContactID = c.JobCompanyContactID;
			


GO

