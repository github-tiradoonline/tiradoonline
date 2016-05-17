IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeDownloadType' AND TYPE = 'U')
DROP TABLE ResumeDownloadType;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeDownloadType' AND TYPE = 'U')
	DROP TABLE ResumeDownloadType;
GO

CREATE TABLE ResumeDownloadType
(
	ResumeDownloadTypeID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ResumeDownloadTypeName		 VARCHAR(100)  NOT NULL,
	ResumeDownloadTypeFileName		 VARCHAR(100)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

