IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyPhoneCall_insert' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompanyPhoneCall_insert;
GO




CREATE PROCEDURE [dbo].[sp_JobCompanyPhoneCall_insert]
	@JobCompanyID				INT,
	@JobCompanyContactID			INT,
	@JobCompanyPhoneCallTypeID		INT,
	@JobCompanyPhoneCallDateTime		DATETIME,
	@JobCompanyPhoneCallPhoneNumber		VARCHAR(50),
	@JobCompanyPhoneCallNotes		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobCompanyPhoneCall 
		(JobCompanyID, JobCompanyContactID, JobCompanyPhoneCallTypeID, JobCompanyPhoneCallDateTime, JobCompanyPhoneCallPhoneNumber, JobCompanyPhoneCallNotes) 
	VALUES
		(@JobCompanyID, @JobCompanyContactID, @JobCompanyPhoneCallTypeID, @JobCompanyPhoneCallDateTime, dbo.fn_FormatPhoneNumber(@JobCompanyPhoneCallPhoneNumber), @JobCompanyPhoneCallNotes) 

	SELECT @@IDENTITY;


GO

