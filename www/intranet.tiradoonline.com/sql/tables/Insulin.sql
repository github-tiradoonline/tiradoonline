IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Insulin' AND TYPE = 'U')
DROP TABLE Insulin;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Insulin' AND TYPE = 'U')
	DROP TABLE Insulin;
GO

CREATE TABLE Insulin
(
	InsulinID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	InsulinDateTime		 DATETIME  NOT NULL,
	Units		 NUMERIC(4,2)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

