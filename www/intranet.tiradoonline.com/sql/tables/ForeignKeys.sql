IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ForeignKeys' AND TYPE = 'U')
DROP TABLE ForeignKeys;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ForeignKeys' AND TYPE = 'U')
	DROP TABLE ForeignKeys;
GO

CREATE TABLE ForeignKeys
(
	fkid		 INT  NULL

);
GO


GO

