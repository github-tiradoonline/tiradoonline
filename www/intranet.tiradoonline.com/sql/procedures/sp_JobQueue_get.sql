IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobQueue_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobQueue_get;
GO



CREATE PROCEDURE [dbo].[sp_JobQueue_get]
	@UserID				INT
AS

	SELECT TOP 20 
		b.JobCompanyContactID,
		a.JobCompanyID,
		c.JobID,
		Created = b.create_dt,
		a.JobCompanyName,
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		c.JobPosition
	FROM
		JobCompany a,
		JobCompanyContact b,
		Jobs c,
		JobQueue d
	WHERE
		a.JobCompanyID = b.JobCompanyID AND
		b.JobCompanyContactID = c.JobCompanyContactID AND
		c.JobID = d.JobID AND
		a.UserID = @UserID
	ORDER BY
		b.create_dt DESC;





GO

