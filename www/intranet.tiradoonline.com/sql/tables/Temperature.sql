IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Temperature' AND TYPE = 'U')
DROP TABLE Temperature;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Temperature' AND TYPE = 'U')
	DROP TABLE Temperature;
GO

CREATE TABLE Temperature
(
	TemperatureID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TemperatureDateTime		 DATETIME  NOT NULL,
	Temperature		 NUMERIC(5,1)  NOT NULL,
	TemperatureComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

