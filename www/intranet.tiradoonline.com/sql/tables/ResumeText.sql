IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeText' AND TYPE = 'U')
DROP TABLE ResumeText;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeText' AND TYPE = 'U')
	DROP TABLE ResumeText;
GO

CREATE TABLE ResumeText
(
	ResumeTextID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	ResumeTextName		 VARCHAR(50)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

