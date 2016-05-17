IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Timesheet' AND TYPE = 'U')
DROP TABLE Timesheet;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Timesheet' AND TYPE = 'U')
	DROP TABLE Timesheet;
GO

CREATE TABLE Timesheet
(
	TimesheetID		IDENTITY (1001,1) INT  NOT NULL,
	TimesheetCompanyID		 INT  NOT NULL,
	TimesheetInvoiceDate		 DATETIME DEFAULT (getdate()) NOT NULL,
	TimesheetInvoiceNumber		 VARCHAR(50)  NOT NULL,
	TimesheetHourlyRate		 NUMERIC(9,2)  NOT NULL,
	TimesheetStartDate		 DATETIME  NOT NULL,
	TimesheetEndDate		 DATETIME  NOT NULL,
	TimesheetHTML		 VARCHAR(MAX)  NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

