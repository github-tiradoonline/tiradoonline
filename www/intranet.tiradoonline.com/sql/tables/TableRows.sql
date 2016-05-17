IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TableRows' AND TYPE = 'U')
DROP TABLE TableRows;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'TableRows' AND TYPE = 'U')
	DROP TABLE TableRows;
GO

CREATE TABLE TableRows
(
	ObjectID		 VARCHAR(50)  NOT NULL,
	ObjectName		 VARCHAR(50)  NOT NULL,
	TableOwner		 VARCHAR(50)  NOT NULL,
	TableRows		 INT  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO


GO

