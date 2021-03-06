IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PageLogs' AND TYPE = 'U')
DROP TABLE PageLogs;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'PageLogs' AND TYPE = 'U')
	DROP TABLE PageLogs;
GO

CREATE TABLE PageLogs
(
	PageLogID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	SCRIPT_NAME		 TEXT  NOT NULL,
	Template		 VARCHAR(100)  NULL,
	Action		 VARCHAR(100)  NULL,
	REQUEST_METHOD		 VARCHAR(20)  NULL,
	QUERY_STRING		 VARCHAR(MAX)  NULL,
	FORM		 VARCHAR(MAX)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

