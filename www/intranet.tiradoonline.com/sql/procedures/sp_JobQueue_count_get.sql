IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobQueue_count_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobQueue_count_get;
GO



CREATE PROCEDURE [dbo].[sp_JobQueue_count_get]
	@UserID				INT
AS

	SELECT 
		COUNT(*)
	FROM
		JobCompany a,
		JobCompanyContact b,
		Jobs c,
		JobQueue d
	WHERE
		a.JobCompanyID = b.JobCompanyID AND
		b.JobCompanyContactID = c.JobCompanyContactID AND
		c.JobID = d.JobID AND
		a.UserID = @UserID;




GO

