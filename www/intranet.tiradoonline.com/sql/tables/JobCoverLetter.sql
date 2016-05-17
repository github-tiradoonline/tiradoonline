IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCoverLetter' AND TYPE = 'U')
DROP TABLE JobCoverLetter;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobCoverLetter' AND TYPE = 'U')
	DROP TABLE JobCoverLetter;
GO

CREATE TABLE JobCoverLetter
(
	JobCoverLetterID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	JobCoverLetterName		 VARCHAR(100)  NOT NULL,
	JobCoverLetterText		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

