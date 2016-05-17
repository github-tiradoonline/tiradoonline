IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeQueue' AND TYPE = 'U')
DROP TABLE ResumeQueue;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ResumeQueue' AND TYPE = 'U')
	DROP TABLE ResumeQueue;
GO

CREATE TABLE ResumeQueue
(
	ResumeQueueID		IDENTITY (1001,1) INT  NOT NULL,
	CompanyID		 INT  NOT NULL,
	Status		 BIT DEFAULT ((1)) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

