IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryGroupSessions' AND TYPE = 'U')
DROP TABLE RecoveryGroupSessions;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryGroupSessions' AND TYPE = 'U')
	DROP TABLE RecoveryGroupSessions;
GO

CREATE TABLE RecoveryGroupSessions
(
	RecoveryGroupSessionID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryGroupID		 INT  NOT NULL,
	RecoveryCounselorID		 INT  NOT NULL,
	RecoveryGroupSessionDateTime		 DATETIME  NOT NULL,
	ScheduledGroup		 BIT  NOT NULL,
	Comments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

