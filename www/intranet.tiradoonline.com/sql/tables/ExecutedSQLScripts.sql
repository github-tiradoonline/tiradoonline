IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ExecutedSQLScripts' AND TYPE = 'U')
DROP TABLE ExecutedSQLScripts;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ExecutedSQLScripts' AND TYPE = 'U')
	DROP TABLE ExecutedSQLScripts;
GO

CREATE TABLE ExecutedSQLScripts
(
	ExecutedSQLScriptID		IDENTITY (1,1) INT  NOT NULL,
	ApplicationName		 VARCHAR(100)  NULL,
	ExecutedSQLScript		 VARCHAR(1000)  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

