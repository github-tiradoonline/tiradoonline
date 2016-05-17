IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Settings' AND TYPE = 'U')
DROP TABLE Settings;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Settings' AND TYPE = 'U')
	DROP TABLE Settings;
GO

CREATE TABLE Settings
(
	SettingsID		IDENTITY (1,1) INT  NOT NULL,
	UserID		 INT  NULL,
	DebuggingSetting		 BIT DEFAULT ((0)) NULL,
	AdministratorEmail		 VARCHAR(50)  NOT NULL,
	DocumentsDirectory		 VARCHAR(200)  NULL,
	ContactsPhotosDirectory		 VARCHAR(200)  NULL,
	PhotosDirectory		 VARCHAR(200)  NULL,
	MoviesDirectory		 VARCHAR(200)  NULL,
	MusicDirectory		 VARCHAR(200)  NULL,
	SMTPServer		 VARCHAR(100)  NULL,
	SMTPServerPort		 VARCHAR(10)  NULL,
	SMTPServerUserName		 VARCHAR(50)  NULL,
	SMTPServerPassword		 VARCHAR(50)  NULL,
	POP3Server		 VARCHAR(100)  NULL,
	POP3ServerPort		 VARCHAR(10)  NULL,
	POP3ServerUserName		 VARCHAR(50)  NULL,
	POP3ServerPassword		 VARCHAR(50)  NULL,
	PreviousPage		 VARCHAR(MAX)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

