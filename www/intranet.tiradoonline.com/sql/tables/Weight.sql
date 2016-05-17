IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Weight' AND TYPE = 'U')
DROP TABLE Weight;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Weight' AND TYPE = 'U')
	DROP TABLE Weight;
GO

CREATE TABLE Weight
(
	WeightID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	WeightDateTime		 DATETIME  NOT NULL,
	Weight		 INT  NOT NULL,
	WeightLocation		 VARCHAR(100)  NULL,
	WeightComments		 VARCHAR(2000)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

