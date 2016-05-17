IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetDetail' AND TYPE = 'U')
DROP TABLE TimesheetDetail;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetDetail' AND TYPE = 'U')
	DROP TABLE TimesheetDetail;
GO

CREATE TABLE TimesheetDetail
(
	TimesheetDetailID		IDENTITY (1001,1) INT  NOT NULL,
	TimesheetID		 INT  NOT NULL,
	TimesheetDetailDate		 DATETIME  NOT NULL,
	TimesheetHours		 NUMERIC(9,2)  NOT NULL,
	TimesheetDescription		 VARCHAR(2000)  NOT NULL,
	Active		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

