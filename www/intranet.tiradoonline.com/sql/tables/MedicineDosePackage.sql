IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDosePackage' AND TYPE = 'U')
DROP TABLE MedicineDosePackage;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineDosePackage' AND TYPE = 'U')
	DROP TABLE MedicineDosePackage;
GO

CREATE TABLE MedicineDosePackage
(
	MedicineDosePackageID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MedicineDosePackageName		 VARCHAR(100)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATE DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

