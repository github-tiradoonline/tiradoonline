IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_WebsiteEmail_insert' AND TYPE = 'P')
DROP PROCEDURE sp_WebsiteEmail_insert;
GO



CREATE PROCEDURE [dbo].[sp_WebsiteEmail_insert]
	@UserID				INT,
	@WebsiteFromEmail		VARCHAR(50),
	@WebsiteEmailBodyText			VARCHAR(MAX)
AS

	INSERT INTO WebsiteEmail
		(UserID, WebsiteFromEmail, WebsiteEmailBodyText)
	VALUES
		(@UserID, @WebsiteFromEmail, @WebsiteEmailBodyText);



GO

