IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompany_UserID_Search_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompany_UserID_Search_get;
GO



CREATE PROCEDURE [dbo].[sp_JobCompany_UserID_Search_get]
	@UserID				INT,
	@Letter				VARCHAR(20) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Letter = '%' + UPPER(@Letter) + '%';

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




GO

