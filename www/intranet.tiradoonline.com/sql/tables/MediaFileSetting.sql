IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MediaFileSetting' AND TYPE = 'U')
	DROP TABLE MediaFileSetting;
GO

CREATE TABLE MediaFileSetting
(
	MediaFileSettingID		INT IDENTITY(1001, 1) NOT NULL,
	UserID				INT NOT NULL,
	MediaFileType			VARCHAR(100) NOT NULL,
	MediaFileSettingDirectory	VARCHAR(1000) NOT NULL,
	create_dt			DATETIME NOT NULL DEFAULT GETDATE()
);
GO

ALTER TABLE MediaFileSetting ADD CONSTRAINT PK_MediaFileSetting_MediaFileSettingID PRIMARY KEY NONCLUSTERED (MediaFileSettingID);
GO

ALTER TABLE MediaFileSetting ADD CONSTRAINT FK_MediaFileSetting_Users_UserID  FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO

