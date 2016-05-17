IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryGroups' AND TYPE = 'U')
DROP TABLE RecoveryGroups;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryGroups' AND TYPE = 'U')
	DROP TABLE RecoveryGroups;
GO

CREATE TABLE RecoveryGroups
(
	RecoveryGroupID		IDENTITY (1,1) INT  NOT NULL,
	RecoveryProgramID		 INT  NOT NULL,
	RecoveryGroupName		 VARCHAR(50)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

