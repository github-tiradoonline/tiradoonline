IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyContact_Search_get' AND TYPE = 'P')
	DROP PROCEDURE sp_JobCompanyContact_Search_get;
GO

CREATE PROCEDURE sp_JobCompanyContact_Search_get
	@UserID				INT,
	@SearchString			VARCHAR(100)
AS

	SELECT 
		b.JobCompanyContactID,
		a.JobCompanyID,
		Created = b.create_dt,
		a.JobCompanyName,
		b.JobCompanyContactWorkPhone,
		b.JobCompanyContactWorkPhone2,
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = a.JobCompanyID),
		TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = a.JobCompanyID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyContactID = b.JobCompanyID),
		TotalPhoneCalls = (SELECT COUNT(*) FROM JobCompanyPhoneCall WHERE JobCompanyContactID = b.JobCompanyID),
		TotalInterviews = (SELECT COUNT(*) FROM JobInterview WHERE JobCompanyContactID = b.JobCompanyID)
	FROM
		JobCompany a,
		JobCompanyContact b
	WHERE
		a.JobCompanyID = b.JobCompanyID
		AND a.UserID = @UserID
		AND 
			(
				b.JobCompanyContactFirstName LIKE @SearchString + '%' 
				OR b.JobCompanyContactLastName LIKE @SearchString + '%'
				OR b.JobCompanyContactWorkPhone LIKE @SearchString + '%'
				OR b.JobCompanyContactWorkPhone2 LIKE @SearchString + '%'
			)
	ORDER BY
		b.create_dt DESC;
GO

exec sp_JobCompanyContact_Search_get 1001, '(631) 806'