IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompany_UserID_Letter_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompany_UserID_Letter_get;
GO



CREATE PROCEDURE [dbo].[sp_JobCompany_UserID_Letter_get]
	@UserID				INT,
	@Letter				VARCHAR(3) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 IF @Letter IS NOT NULL
		SET @Letter = UPPER(@Letter) + '%';

	 IF @Letter IS NOT NULL
		BEGIN
			IF @Letter = 'ALL'
				SELECT *, 
					TotalCompanies = (SELECT COUNT(*) FROM JobCompany WHERE UserID = @UserID),
					TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID),
					TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID),
					TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID)
				FROM 
					JobCompany 
				WHERE 
					UserID = @UserID
				ORDER BY 
					JobCompanyName;
			ELSE
				SELECT 
					*, 
					TotalCompanies = (SELECT COUNT(*) FROM JobCompany WHERE UserID = @UserID AND UPPER(JobCompanyName) LIKE @Letter),
					TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter),
					TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter),
					TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID AND UPPER(JobCompanyName) LIKE @Letter)
				FROM 
					JobCompany 
				WHERE 
					UserID = @UserID AND
					UPPER(JobCompanyName) LIKE @Letter
				ORDER BY 
					JobCompanyName;
		END
	ELSE
		SELECT 
			*, 
			TotalCompanies = (SELECT COUNT(*) FROM JobCompany WHERE JobCompanyID = JobCompany.JobCompanyID),
			TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = JobCompany.JobCompanyID),
			TotalAddresses = (SELECT COUNT(*) FROM JobCompanyAddress WHERE JobCompanyID = JobCompany.JobCompanyID),
			TotalContacts = (SELECT COUNT(*) FROM JobCompanyContact WHERE JobCompanyID = JobCompany.JobCompanyID) 
		FROM 
			JobCompany 
		WHERE 
			UserID = @UserID 
		ORDER BY 
			JobCompanyName;

END




GO

