IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TaskProject' AND TYPE = 'U')
DROP TABLE TaskProject;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TaskProject' AND TYPE = 'U')
	DROP TABLE TaskProject;
GO

CREATE TABLE TaskProject
(
	TaskProjectID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	TaskProjectName		 VARCHAR(100)  NOT NULL,
	TaksProjectDescription		 VARCHAR(MAX)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

