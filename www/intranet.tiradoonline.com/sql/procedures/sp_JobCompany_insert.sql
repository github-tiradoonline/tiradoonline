IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_JobCompany_insert' AND TYPE = 'P')
DROP PROCEDURE sp_JobCompany_insert;
GO




CREATE PROCEDURE [dbo].[sp_JobCompany_insert]
	@UserID				INT,
	@JobCompanyName			VARCHAR(50),
	@JobCompanyPhone		VARCHAR(50),
	@JobCompanyPhone2		VARCHAR(50),
	@JobCompanyFax			VARCHAR(50),
	@JobCompanyEmail		VARCHAR(100),
	@JobCompanyWebsite		VARCHAR(100),
	@JobCompanyLinkedIn		VARCHAR(500),
	@JobCompanyTwitter		VARCHAR(500),
	@JobCompanyFacebook		VARCHAR(500),
	@JobCompanyGooglePlus		VARCHAR(500),
	@JobCompanyYouTube		VARCHAR(500),
	@JobCompanyInstagram		VARCHAR(500),
	@JobCompanyPinterest		VARCHAR(500)
AS
	
	
	INSERT INTO JobCompany 
		(UserID, JobCompanyName, JobCompanyPhone, JobCompanyPhone2, JobCompanyFax, JobCompanyEmail, JobCompanyWebsite, JobCompanyLinkedIn, JobCompanyTwitter, JobCompanyFacebook, JobCompanyGooglePlus, JobCompanyYouTube, JobCompanyInstagram, JobCompanyPinterest) 
	VALUES
		(@UserID, @JobCompanyName, dbo.fn_FormatPhoneNumber(@JobCompanyPhone), dbo.fn_FormatPhoneNumber(@JobCompanyPhone2), dbo.fn_FormatPhoneNumber(@JobCompanyFax), @JobCompanyEmail, @JobCompanyWebsite, @JobCompanyLinkedIn, @JobCompanyTwitter, @JobCompanyFacebook, @JobCompanyGooglePlus, @JobCompanyYouTube, @JobCompanyInstagram, @JobCompanyPinterest);

	SELECT @@IDENTITY;


GO

