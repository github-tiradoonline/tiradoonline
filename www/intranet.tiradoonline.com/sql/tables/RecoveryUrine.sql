IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryUrine' AND TYPE = 'U')
DROP TABLE RecoveryUrine;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryUrine' AND TYPE = 'U')
	DROP TABLE RecoveryUrine;
GO

CREATE TABLE RecoveryUrine
(
	RecoveryUrineID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryProgramID		 INT  NOT NULL,
	RecoveryUrineDateTime		 DATETIME  NOT NULL,
	RecoveryUrineResult		 BIT DEFAULT ((0)) NOT NULL,
	RecoveryUrineDescription		 VARCHAR(1000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

