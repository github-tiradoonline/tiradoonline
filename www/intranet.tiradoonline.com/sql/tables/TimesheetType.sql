UPDATE Timesheet SET TimesheetTypeID = 1002;

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME = 'FK_Timesheet_TimesheetType_TimesheetTypeID' AND TYPE='F')
	ALTER TABLE Timesheet DROP CONSTRAINT FK_Timesheet_TimesheetType_TimesheetTypeID;
GO


IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TimesheetType' AND TYPE = 'U')
	DROP TABLE TimesheetType;
GO

CREATE TABLE TimesheetType
(
	TimesheetTypeID		INT IDENTITY(1001, 1) NOT NULL,
	TimesheetType		VARCHAR(100) NOT NULL,
	create_dt			DATETIME NOT NULL DEFAULT GETDATE()
);
GO

ALTER TABLE TimesheetType ADD CONSTRAINT PK_TimesheetType_TimesheetTypeID PRIMARY KEY NONCLUSTERED (TimesheetTypeID);
GO

ALTER TABLE Timesheet ADD CONSTRAINT FK_Timesheet_TimesheetType_TimesheetTypeID FOREIGN KEY (TimesheetTypeID) REFERENCES TimesheetType(TimesheetTypeID);
GO


INSERT INTO TimesheetType (TimesheetType) VALUES ('Daily');
INSERT INTO TimesheetType (TimesheetType) VALUES ('Hourly');
INSERT INTO TimesheetType (TimesheetType) VALUES ('Weekly');
GO
