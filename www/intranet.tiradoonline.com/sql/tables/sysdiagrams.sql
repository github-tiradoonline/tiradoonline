IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sysdiagrams' AND TYPE = 'U')
DROP TABLE sysdiagrams;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'sysdiagrams' AND TYPE = 'U')
	DROP TABLE sysdiagrams;
GO

CREATE TABLE sysdiagrams
(
	name		IDENTITY (1,1) NVARCHAR(256)  NOT NULL,
	name		 SYSNAME(256)  NOT NULL,
	principal_id		 INT  NOT NULL,
	diagram_id		 INT  NOT NULL,
	version		 INT  NULL,
	definition		 VARBINARY  NULL

);
GO




GO

GO

