IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobInterview_ClientID_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobInterview_ClientID_get;
GO




CREATE PROCEDURE [dbo].[sp_JobInterview_ClientID_get]
	@JobCompanyID			INT
AS
	
	
	SELECT
		a.JobCompanyID,
		a.JobCompanyName
	FROM
		JobCompany a
	WHERE
		a.JobCompanyID NOT IN
			(
				SELECT
					b.JobCompanyID
				FROM
					JobCompany b
				WHERE
					b.UserID = a.UserID
					AND b.JobCompanyID <> a.JobCompanyID
			)
		AND a.JobCompanyID IN
			(
				SELECT 
					JobCompanyID
				FROM
					JobCompanyContact
			)
	ORDER BY
		a.JobCompanyName;


GO

exec sp_JobInterview_ClientID_get 1001