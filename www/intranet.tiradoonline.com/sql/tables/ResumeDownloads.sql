IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeDownloads' AND TYPE = 'U')
DROP TABLE ResumeDownloads;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeDownloads' AND TYPE = 'U')
	DROP TABLE ResumeDownloads;
GO

CREATE TABLE ResumeDownloads
(
	ResumeDownloadID		IDENTITY (1001,1) INT  NOT NULL,
	FullName		 VARCHAR(50)  NULL,
	Company		 VARCHAR(50)  NULL,
	Phone		 VARCHAR(50)  NULL,
	Email		 VARCHAR(50)  NOT NULL,
	Comments		 VARCHAR(1000)  NULL,
	Website		 VARCHAR(100)  NULL,
	ReferencedByID		 INT  NOT NULL,
	ResumeDownloadTypeID		 INT  NOT NULL,
	Referer		 VARCHAR(1000)  NULL,
	SessionID		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

