IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobInterviewType' AND TYPE = 'U')
DROP TABLE JobInterviewType;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobInterviewType' AND TYPE = 'U')
	DROP TABLE JobInterviewType;
GO

CREATE TABLE JobInterviewType
(
	JobInterviewTypeID		IDENTITY (1,1) INT  NOT NULL,
	JobInterviewType		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

