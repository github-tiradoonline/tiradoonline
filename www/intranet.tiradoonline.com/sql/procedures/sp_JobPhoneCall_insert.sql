IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobPhoneCall_insert' AND TYPE = 'P')
DROP PROCEDURE sp_JobPhoneCall_insert;
GO




CREATE PROCEDURE [dbo].[sp_JobPhoneCall_insert]
	@JobCompanyID		INT,
	@JobPhoneCallDateTime		DATETIME,
	@JobPhoneCallPhoneNumber	VARCHAR(50),
	@JobPhoneCallNotes		VARCHAR(MAX)
AS
	
	
	INSERT INTO JobPhoneCall 
		(JobCompanyID, JobPhoneCallDateTime, JobPhoneCallPhoneNumber, JobPhoneCallNotes) 
	VALUES
		(@JobCompanyID, @JobPhoneCallDateTime, dbo.fn_FormatPhoneNumber(@JobPhoneCallPhoneNumber), @JobPhoneCallNotes) 

	SELECT @@IDENTITY;


GO

