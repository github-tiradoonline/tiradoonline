IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetPayment' AND TYPE = 'U')
DROP TABLE TimesheetPayment;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetPayment' AND TYPE = 'U')
	DROP TABLE TimesheetPayment;
GO

CREATE TABLE TimesheetPayment
(
	TimesheetPaymentID		 INT  NOT NULL,
	TimesheetCompanyID		 INT  NOT NULL,
	TimesheetPaymentDate		 DATETIME  NOT NULL,
	TimesheetPayment		 NUMERIC(9,2)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME  NOT NULL

);
GO




GO


GO

