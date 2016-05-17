IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetImport' AND TYPE = 'U')
DROP TABLE SnippetImport;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetImport' AND TYPE = 'U')
	DROP TABLE SnippetImport;
GO

CREATE TABLE SnippetImport
(
	SnippetID		 INT  NOT NULL,
	SnippetFolderID		 INT  NOT NULL,
	SnippetName		 VARCHAR(30)  NOT NULL,
	SnippetDescription		 TEXT  NOT NULL,
	SnippetShare		 BIT  NOT NULL,
	DateCreated		 DATETIME  NOT NULL

);
GO


GO

