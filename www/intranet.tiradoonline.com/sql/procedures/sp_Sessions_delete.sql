IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Sessions_delete' AND TYPE = 'P')
DROP PROCEDURE sp_Sessions_delete;
GO



CREATE PROCEDURE [dbo].[sp_Sessions_delete]
	@JobCompanyID				INT
AS

	SELECT 
		a.*, 
		JobCompanyContactName = 
			CASE 
				WHEN b.JobCompanyContactFirstName <> '' AND b.JobCompanyContactLastName = '' THEN
					b.JobCompanyContactFirstName
				WHEN b.JobCompanyContactFirstName = '' AND b.JobCompanyContactLastName <> '' THEN
					b.JobCompanyContactLastName
				ELSE
					b.JobCompanyContactLastName + ', ' + b.JobCompanyContactFirstName
			END,
		JobStateName = (SELECT State FROM States WHERE StateID = a.JobStateID),
		TotalJobs = (SELECT COUNT(*) FROM Jobs WHERE JobCompanyID = @JobCompanyID) 
	FROM 
		Jobs a, 
		JobCompanyContact b 
	WHERE 
		a.JobCompanyContactID = b. JobCompanyContactID AND 
		a.JobCompanyID = @JobCompanyID
	ORDER BY 
		a.create_dt DESC;




GO

