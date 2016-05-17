IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeFile' AND TYPE = 'U')
DROP TABLE ResumeFile;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeFile' AND TYPE = 'U')
	DROP TABLE ResumeFile;
GO

CREATE TABLE ResumeFile
(
	ResumeFileID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ResumeFileName		 VARCHAR(50)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

