IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineRefill' AND TYPE = 'U')
DROP TABLE MedicineRefill;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'MedicineRefill' AND TYPE = 'U')
	DROP TABLE MedicineRefill;
GO

CREATE TABLE MedicineRefill
(
	MedicineRefillID		IDENTITY (1001,1) INT  NOT NULL,
	MedicineID		 INT  NOT NULL,
	PharmacyID		 INT  NOT NULL,
	DoctorID		 INT  NOT NULL,
	RefillOrderDate		 DATETIME  NULL,
	RefillOrderPickupDate		 DATETIME  NULL,
	RefillDateFilled		 DATETIME  NULL,
	RefillAmount		 NUMERIC(9,2) DEFAULT ((0)) NULL,
	DailyAmount		 NUMERIC(9,2) DEFAULT ((0)) NULL,
	RefillTimes		 INT DEFAULT ((0)) NULL,
	RefillUntilDate		 DATETIME  NULL,
	RefillDiscardDate		 DATETIME  NULL,
	RefillDescription		 VARCHAR(5000)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

