IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompanyContact_insert' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompanyContact_insert;
GO



CREATE PROCEDURE [dbo].[sp_JobCompanyContact_insert]
	@JobCompanyID				INT, 
	@JobCompanyContactTitle			VARCHAR(100), 
	@JobCompanyContactFirstName		VARCHAR(50),
	@JobCompanyContactLastName		VARCHAR(50), 
	@JobCompanyContactWorkPhone		VARCHAR(50), 
	@JobCompanyContactCellPhone		VARCHAR(50), 
	@JobCompanyContactFax			VARCHAR(50), 
	@JobCompanyContactEmail			VARCHAR(100),
	@JobCompanyContactEmail2		VARCHAR(100),
	@JobCompanyContactLinkedIn		VARCHAR(500),
	@JobCompanyContactTwitter		VARCHAR(500),
	@JobCompanyContactFacebook		VARCHAR(500),
	@JobCompanyContactGooglePlus		VARCHAR(500),
	@JobCompanyContactInstagram		VARCHAR(500),
	@JobCompanyContactSkype			VARCHAR(500),
	@JobCompanyContactHotmail		VARCHAR(500),
	@JobCompanyContactYahoo			VARCHAR(500),
	@JobCompanyContactAIM			VARCHAR(500),
	@JobCompanyContactGmail			VARCHAR(500),
	@JobCompanyContactNotes			VARCHAR(MAX)
AS

	INSERT INTO JobCompanyContact
		(JobCompanyID, JobCompanyContactTitle, JobCompanyContactFirstName, JobCompanyContactLastName, JobCompanyContactWorkPhone, JobCompanyContactCellPhone, JobCompanyContactFax, JobCompanyContactEmail, JobCompanyContactEmail2, JobCompanyContactLinkedIn, JobCompanyContactTwitter, JobCompanyContactFacebook, JobCompanyContactGooglePlus, JobCompanyContactInstagram, JobCompanyContactSkype, JobCompanyContactHotmail, JobCompanyContactYahoo, JobCompanyContactAIM, JobCompanyContactGmail, JobCompanyContactNotes)
	VALUES
		(@JobCompanyID, @JobCompanyContactTitle, @JobCompanyContactFirstName, @JobCompanyContactLastName, dbo.fn_FormatPhoneNumber(@JobCompanyContactWorkPhone), dbo.fn_FormatPhoneNumber(@JobCompanyContactCellPhone), dbo.fn_FormatPhoneNumber(@JobCompanyContactFax), @JobCompanyContactEmail, @JobCompanyContactEmail2, @JobCompanyContactLinkedIn, @JobCompanyContactTwitter, @JobCompanyContactFacebook, @JobCompanyContactGooglePlus, @JobCompanyContactInstagram, @JobCompanyContactSkype, @JobCompanyContactHotmail, @JobCompanyContactYahoo, @JobCompanyContactAIM, @JobCompanyContactGmail, @JobCompanyContactNotes);


	SELECT @@IDENTITY;



GO

