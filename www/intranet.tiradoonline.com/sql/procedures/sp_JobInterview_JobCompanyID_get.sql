IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobInterview_JobCompanyID_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobInterview_JobCompanyID_get;
GO




CREATE PROCEDURE [dbo].[sp_JobInterview_JobCompanyID_get]
	@JobCompanyID			INT
AS
	
	
	SELECT 
		a.*, 
		b.State, 
		JobInterviewClientName = 
			(SELECT JobCompanyName FROM JobCompany WHERE JobCompanyID = a.JobInterviewClientID), 
		JobInterviewContactName = 
			(SELECT JobCompanyClientName =  
				CASE 
					WHEN JobCompanyContactFirstName <> '' AND JobCompanyContactLastName = '' THEN
						JobCompanyContactFirstName
					WHEN JobCompanyContactFirstName = '' AND JobCompanyContactLastName <> '' THEN
						JobCompanyContactLastName
					ELSE
						JobCompanyContactLastName + ', ' + JobCompanyContactFirstName
				END
			FROM 
				JobCompanyContact
			WHERE 
				JobCompanyContactID = a.JobInterviewClientContactID), 
		JobInterviewType = (SELECT JobInterviewType FROM JobInterviewType WHERE JobInterviewTypeID = a.JobInterviewTypeID), 
		TotalInterviews = 
			(SELECT COUNT(*) FROM JobInterview WHERE JobCompanyID = @JobCompanyID) 
	FROM 
		JobInterview a, 
		States b 
	WHERE 
		a.StateID = b.StateID AND 
		(a.JobCompanyID = @JobCompanyID OR a.JobInterviewClientID = @JobCompanyID)
	ORDER BY create_dt;


GO

exec sp_JobInterview_JobCompanyID_get 1667