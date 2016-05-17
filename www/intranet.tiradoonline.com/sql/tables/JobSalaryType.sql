IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobSalaryType' AND TYPE = 'U')
DROP TABLE JobSalaryType;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobSalaryType' AND TYPE = 'U')
	DROP TABLE JobSalaryType;
GO

CREATE TABLE JobSalaryType
(
	JobSalaryTypeID		IDENTITY (1001,1) INT  NOT NULL,
	JobSalaryType		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

