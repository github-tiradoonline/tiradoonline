IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_EmailTemplates_update' AND TYPE = 'P')
DROP PROCEDURE sp_EmailTemplates_update;
GO




CREATE PROCEDURE [dbo].[sp_EmailTemplates_update]
	@UserID				INT, 
	@CreateAccountSubject		VARCHAR(200), 
	@CreateAccountEmail		VARCHAR(MAX), 
	@ForgotPasswordSubject		VARCHAR(200), 
	@ForgotPasswordEmail		VARCHAR(MAX)
AS

	IF NOT EXISTS (SELECT 1 FROM EmailTemplates WHERE UserID = @UserID)
		BEGIN
			INSERT INTO EmailTemplates
				(UserID, CreateAccountSubject, CreateAccountEmail, ForgotPasswordSubject, ForgotPasswordEmail)
			VALUES
				(@UserID, @CreateAccountSubject, @CreateAccountEmail, @ForgotPasswordSubject, @ForgotPasswordEmail);
		END 	
	ELSE
		BEGIN
			UPDATE EmailTemplates SET
				CreateAccountSubject = @CreateAccountSubject,
				CreateAccountEmail = @CreateAccountEmail, 
				ForgotPasswordSubject = @ForgotPasswordSubject,
				ForgotPasswordEmail = @ForgotPasswordEmail
			WHERE
				UserID = @UserID;
		END 	



GO

