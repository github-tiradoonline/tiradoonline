IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Medicine' AND TYPE = 'U')
DROP TABLE Medicine;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Medicine' AND TYPE = 'U')
	DROP TABLE Medicine;
GO

CREATE TABLE Medicine
(
	MedicineID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MedicineName		 VARCHAR(50)  NOT NULL,
	GenericName		 VARCHAR(50)  NOT NULL,
	PrescriptionNumber		 VARCHAR(30)  NULL,
	UnitID		 INT  NOT NULL,
	MedicineDescription		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

