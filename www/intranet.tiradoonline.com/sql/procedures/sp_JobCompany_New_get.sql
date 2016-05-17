IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompany_New_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompany_New_get;
GO



CREATE PROCEDURE [dbo].[sp_JobCompany_New_get]
	@UserID				INT
AS

	SELECT TOP 20 
		b.JobCompanyID,
		Created = b.create_dt,
		b.JobCompanyName,
		b.JobCompanyWebsite,
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = b.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = b.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyContactID = b.JobCompanyID),
		TotalPhoneCalls = (SELECT COUNT(*) FROM JobCompanyPhoneCall WHERE JobCompanyContactID = b.JobCompanyID),
		TotalInterviews = (SELECT COUNT(*) FROM JobInterview WHERE JobCompanyID = b.JobCompanyID)
	FROM
		JobCompany b
	WHERE
		b.UserID = @UserID
	ORDER BY
		b.create_dt DESC;





GO

EXEC sp_JobCompany_New_get 1001