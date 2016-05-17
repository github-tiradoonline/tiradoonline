IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobInterview' AND TYPE = 'U')
DROP TABLE JobInterview;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobInterview' AND TYPE = 'U')
	DROP TABLE JobInterview;
GO

CREATE TABLE JobInterview
(
	JobInterviewID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobInterviewTypeID		 INT  NOT NULL,
	JobInterviewClientID		 INT  NOT NULL,
	JobInterviewClientContactID		 INT  NOT NULL,
	JobInterviewDateTime		 DATETIME  NOT NULL,
	JobInterviewAddress1		 VARCHAR(50)  NULL,
	JobInterviewAddress2		 VARCHAR(50)  NULL,
	JobInterviewCity		 VARCHAR(50)  NULL,
	StateID		 INT  NULL,
	JobInterviewZipCode		 VARCHAR(20)  NULL,
	JobInterviewNotes		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

