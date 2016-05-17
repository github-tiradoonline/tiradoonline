IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDose' AND TYPE = 'U')
DROP TABLE MedicineDose;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDose' AND TYPE = 'U')
	DROP TABLE MedicineDose;
GO

CREATE TABLE MedicineDose
(
	MedicineDoseID		IDENTITY (1001,1) INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	MedicineDoseDateTime		 DATETIME  NOT NULL,
	MedicineDoseDescription		 VARCHAR(2000)  NULL,
	Amount		 NUMERIC(9,2)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

