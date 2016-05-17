IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sp_Settings_update' AND TYPE = 'P')
DROP PROCEDURE sp_Settings_update;
GO





CREATE PROCEDURE [dbo].[sp_Settings_update]
	 @UserID			INT,
	 @DebuggingSetting		BIT,
         @AdministratorEmail            VARCHAR(50),
	 @ContactsPhotosDirectory	VARCHAR(200),
         @DocumentsDirectory            VARCHAR(200),
         @PhotosDirectory            	VARCHAR(200),
         @MusicDirectory              	VARCHAR(200),
         @MoviesDirectory              	VARCHAR(200),
         @SMTPServer              	VARCHAR(100),
	 @SMTPServerPort		VARCHAR(10),
         @SMTPServerUserName           	VARCHAR(100),
         @SMTPServerPassword           	VARCHAR(100),
	 @POP3Server			VARCHAR(100),
	 @POP3ServerPort		VARCHAR(10),
	 @POP3ServerUserName		VARCHAR(100),
	 @POP3ServerPassword		VARCHAR(10)
AS


	UPDATE Settings SET
		DebuggingSetting = @DebuggingSetting,
		AdministratorEmail = @AdministratorEmail,
		ContactsPhotosDirectory = @ContactsPhotosDirectory, 
		DocumentsDirectory = @DocumentsDirectory, 
		PhotosDirectory = @PhotosDirectory, 
		MusicDirectory = @MusicDirectory,
		MoviesDirectory = @MoviesDirectory,
		SMTPServer = @SMTPServer,
		SMTPServerPort = @SMTPServerPort,
		SMTPServerUserName = @SMTPServerUserName,
		SMTPServerPassword = @SMTPServerPassword,
		POP3Server = @POP3Server,
		POP3ServerPort = @POP3ServerPort,
		POP3ServerUserName = @POP3ServerUserName,
		POP3ServerPassword = @POP3ServerPassword
	WHERE
		UserID = @UserID;




GO

