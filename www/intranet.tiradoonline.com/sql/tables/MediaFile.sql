IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MediaFile' AND TYPE = 'U')
	DROP TABLE MediaFile;
GO

CREATE TABLE MediaFile
(
	MediaFileID		INT IDENTITY(1001, 1) NOT NULL,
	UserID			INT NOT NULL,
	MediaFileType		VARCHAR(100) NOT NULL,
	MediaFileDirectory	VARCHAR(1000) NOT NULL,
	MediaFileName		VARCHAR(1000) NOT NULL,
	create_dt		DATETIME NOT NULL DEFAULT GETDATE()
);
GO

ALTER TABLE MediaFile ADD CONSTRAINT PK_MediaFile_MediaFileID PRIMARY KEY NONCLUSTERED (MediaFileID);
GO

ALTER TABLE MediaFile ADD CONSTRAINT FK_MediaFile_Users_UserID  FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO
