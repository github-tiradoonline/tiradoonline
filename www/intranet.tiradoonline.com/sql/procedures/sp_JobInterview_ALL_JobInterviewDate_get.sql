IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobInterview_ALL_JobInterviewDate_get' AND TYPE = 'P')
	DROP PROCEDURE sp_JobInterview_ALL_JobInterviewDate_get;
GO

CREATE PROCEDURE sp_JobInterview_ALL_JobInterviewDate_get
	@UserID				INT,
	@JobInterviewDate		SMALLDATETIME
AS

	SELECT
		b.JobCompanyName,
		c.JobInterviewType,
		JobInterviewContact = (SELECT InterviewContact = dbo.fn_FormatName(JobCompanyContactFirstName, JobCompanyContactLastName, '') FROM JobCompanyContact WHERE JobCompanyContactID = a.JobInterviewClientContactID),
		JobInterviewDateTime = a.JobInterviewDateTime,
		JobInterviewAddress1 = a.JobInterviewAddress1,
		JobInterviewAddress2 = a.JobInterviewAddress2,
		JobInterviewCity = a.JobInterviewCity,
		JobInterviewState = (SELECT StateAbbr FROM States WHERE StateID = a.StateID),
		JobInterviewZipCode = a.JobInterviewZipCode,
		JobCompanyID = a.JobCompanyID,
		*
	FROM 
		JobInterview a,
		JobCompany b,
		JobInterviewType c
	WHERE
		a.JobCompanyID = b.JobCompanyID
		AND a.JobInterviewTypeID = c.JobInterviewTypeID
		AND b.UserID = @UserID
		AND DATEPART(month, JobInterviewDateTime) = MONTH(@JobInterviewDate)
		AND DATEPART(year, JobInterviewDateTime) = YEAR(@JobInterviewDate)
	ORDER BY
		JobInterviewDateTime



GO
EXEC sp_JobInterview_ALL_JobInterviewDate_get 1001, '7/1/15'