IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TestResult' AND TYPE = 'U')
DROP TABLE TestResult;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TestResult' AND TYPE = 'U')
	DROP TABLE TestResult;
GO

CREATE TABLE TestResult
(
	TestResultID		 INT  NOT NULL,
	TestResultName		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

