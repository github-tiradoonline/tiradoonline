IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobQueue' AND TYPE = 'U')
DROP TABLE JobQueue;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'JobQueue' AND TYPE = 'U')
	DROP TABLE JobQueue;
GO

CREATE TABLE JobQueue
(
	JobQueueID		IDENTITY (1001,1) INT  NOT NULL,
	JobID		 INT  NOT NULL,
	sent_dt		 DATETIME  NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

