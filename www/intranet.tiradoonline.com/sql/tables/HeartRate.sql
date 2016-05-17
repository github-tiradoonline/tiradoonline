IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HeartRate' AND TYPE = 'U')
DROP TABLE HeartRate;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'HeartRate' AND TYPE = 'U')
	DROP TABLE HeartRate;
GO

CREATE TABLE HeartRate
(
	HeartRateID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	HeartRateDateTime		 DATETIME  NOT NULL,
	HeartRate		 SMALLINT  NOT NULL,
	HeartRateComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

