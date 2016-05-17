IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryCounselors' AND TYPE = 'U')
DROP TABLE RecoveryCounselors;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryCounselors' AND TYPE = 'U')
	DROP TABLE RecoveryCounselors;
GO

CREATE TABLE RecoveryCounselors
(
	RecoveryCounselorID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryProgramID		 INT  NOT NULL,
	FirstName		 VARCHAR(20)  NULL,
	LastName		 VARCHAR(30)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

