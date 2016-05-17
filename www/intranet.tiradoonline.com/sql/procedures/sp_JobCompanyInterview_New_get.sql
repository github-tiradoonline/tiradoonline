IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobInterview_New_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobInterview_New_get;
GO



CREATE PROCEDURE [dbo].[sp_JobInterview_New_get]
	@UserID				INT
AS

	SELECT TOP 20 
		b.JobCompanyID,
		Created = b.JobInterviewDateTime,
		a.JobCompanyName,
		a.JobCompanyWebsite,
		b.JobInterviewAddress1,
		b.JobInterviewAddress2,
		b.JobInterviewCity,
		State = (SELECT StateAbbr FROM States WHERE StateID = b.StateID),
		b.JobInterviewZipCode,
		JobInterviewType = (SELECT JobInterviewType FROM JobInterviewType WHERE JobInterviewTypeID = b.JobInterviewTypeID),
		JobInterviewClientCompanyName = (SELECT JobCompanyName FROM JobCompany WHERE JobCompanyID = (SELECT JobCompanyID FROM JobCompanyContact WHERE JobCompanyContactID = b.JobInterviewClientContactID)),
		b.JobInterviewClientContactID,
		JobInterviewClientContactName = (SELECT dbo.fn_FormatName(JobCompanyContactFirstName, JobCompanyContactLastName, '') FROM JobCompanyContact WHERE JobCompanyContactID = b.JobInterviewClientContactID),
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = b.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = b.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyContactID = b.JobCompanyID),
		TotalPhoneCalls = (SELECT COUNT(*) FROM JobCompanyPhoneCall WHERE JobCompanyContactID = b.JobCompanyID),
		TotalInterviews = (SELECT COUNT(*) FROM JobInterview WHERE JobCompanyID = b.JobCompanyID)
	FROM
		JobCompany a,
		JobInterview b
	WHERE
		a.JobCompanyID = b.JobCompanyID
		AND a.UserID = @UserID
	ORDER BY
		b.JobInterviewDateTime DESC;





GO

EXEC sp_JobInterview_New_get 1001