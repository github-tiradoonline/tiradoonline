IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Jobs' AND TYPE = 'U')
DROP TABLE Jobs;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Jobs' AND TYPE = 'U')
	DROP TABLE Jobs;
GO

CREATE TABLE Jobs
(
	JobID		IDENTITY (1001,1) INT  NOT NULL,
	JobCompanyID		 INT  NOT NULL,
	JobCompanyContactID		 INT  NOT NULL,
	JobSalaryTypeID		 INT  NOT NULL,
	JobDate		 DATETIME  NOT NULL,
	JobPosition		 VARCHAR(500)  NOT NULL,
	JobSalary		 NUMERIC(9,2)  NOT NULL,
	JobClient		 VARCHAR(100)  NULL,
	JobCity		 VARCHAR(50)  NOT NULL,
	JobStateID		 INT  NOT NULL,
	JobRequirements		 VARCHAR(MAX)  NOT NULL,
	JobNotes		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

