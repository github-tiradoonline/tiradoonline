IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyPhoneCall_New_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompanyPhoneCall_New_get;
GO



CREATE PROCEDURE [dbo].[sp_JobCompanyPhoneCall_New_get]
	@UserID				INT
AS

	SELECT TOP 20 
		b.JobCompanyID,
		b.JobCompanyContactID,
		Created = b.JobCompanyPhoneCallDateTime,
		a.JobCompanyName,
		a.JobCompanyWebsite,
		b.JobCompanyPhoneCallPhoneNumber,
		JobCompanyPhoneCallType = (SELECT JobCompanyPhoneCallType FROM JobCompanyPhoneCallType WHERE JobCompanyPhoneCallTypeID = b.JobCompanyPhoneCallTypeID),
		JobCompanyContactName = (SELECT dbo.fn_FormatName(JobCompanyContactFirstName, JobCompanyContactLastName, '') FROM JobCompanyContact WHERE JobCompanyContactID = b.JobCompanyContactID),
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = b.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = b.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyContactID = b.JobCompanyID),
		TotalPhoneCalls = (SELECT COUNT(*) FROM JobCompanyPhoneCall WHERE JobCompanyContactID = b.JobCompanyID),
		TotalInterviews = (SELECT COUNT(*) FROM JobCompanyPhoneCall WHERE JobCompanyID = b.JobCompanyID)
	FROM
		JobCompany a,
		JobCompanyPhoneCall b
	WHERE
		a.JobCompanyID = b.JobCompanyID
		AND a.UserID = @UserID
	ORDER BY
		b.JobCompanyPhoneCallDateTime DESC;





GO

EXEC sp_JobCompanyPhoneCall_New_get 1001