IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDosePackageItem' AND TYPE = 'U')
DROP TABLE MedicineDosePackageItem;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDosePackageItem' AND TYPE = 'U')
	DROP TABLE MedicineDosePackageItem;
GO

CREATE TABLE MedicineDosePackageItem
(
	MedicineDosePackageItemID		IDENTITY (1001,1) INT  NOT NULL,
	MedicineDosePackageID		 INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	Amount		 NUMERIC(9,2) DEFAULT ((0)) NOT NULL,
	Description		 VARCHAR(200)  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

