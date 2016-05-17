IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryPrograms' AND TYPE = 'U')
DROP TABLE RecoveryPrograms;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryPrograms' AND TYPE = 'U')
	DROP TABLE RecoveryPrograms;
GO

CREATE TABLE RecoveryPrograms
(
	RecoveryProgramID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NULL,
	RecoveryTypeID		 INT  NOT NULL,
	ProgramName		 VARCHAR(50)  NOT NULL,
	start_dt		 DATETIME  NOT NULL,
	end_dt		 DATETIME  NULL,
	sober_dt		 DATETIME  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

