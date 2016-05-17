IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyPhoneCall_JobCompanyID_get' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompanyPhoneCall_JobCompanyID_get;
GO




CREATE PROCEDURE [dbo].[sp_JobCompanyPhoneCall_JobCompanyID_get]
	@JobCompanyID			INT
AS
	
	
	SELECT 
		a.*,
		JobCompanyPhoneCallContactName = 
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
				JobCompanyContactID = a.JobCompanyContactID),
		JobCompanyPhoneCallType = (SELECT JobCompanyPhoneCallType FROM JobCompanyPhoneCallType WHERE JobCompanyPhoneCallTypeID = a.JobCompanyPhoneCallTypeID)
	FROM 
		JobCompanyPhoneCall a
	WHERE 
		a.JobCompanyID = @JobCompanyID 
	ORDER BY 
		a.create_dt DESC;


GO

