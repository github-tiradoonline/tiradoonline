IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryTypes' AND TYPE = 'U')
DROP TABLE RecoveryTypes;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'RecoveryTypes' AND TYPE = 'U')
	DROP TABLE RecoveryTypes;
GO

CREATE TABLE RecoveryTypes
(
	RecoveryTypeID		IDENTITY (1001,1) INT  NOT NULL,
	RecoveryTypeName		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

