IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Pharmacy' AND TYPE = 'U')
DROP TABLE Pharmacy;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Pharmacy' AND TYPE = 'U')
	DROP TABLE Pharmacy;
GO

CREATE TABLE Pharmacy
(
	PharmacyID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	PharmacyName		 VARCHAR(100)  NOT NULL,
	PharmacyAddress		 VARCHAR(100)  NOT NULL,
	PharmacyCity		 VARCHAR(50)  NOT NULL,
	PharmacyStateID		 INT  NOT NULL,
	PharmacyZipCode		 VARCHAR(20)  NOT NULL,
	PharmacyTelephoneNumber		 VARCHAR(20)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

