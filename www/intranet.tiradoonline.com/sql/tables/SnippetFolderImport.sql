IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetFolderImport' AND TYPE = 'U')
DROP TABLE SnippetFolderImport;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetFolderImport' AND TYPE = 'U')
	DROP TABLE SnippetFolderImport;
GO

CREATE TABLE SnippetFolderImport
(
	SnippetFolderID		 INT  NOT NULL,
	UserID		 VARCHAR(100)  NOT NULL,
	SnippetFolderName		 VARCHAR(30)  NOT NULL,
	DateCreated		 DATETIME  NOT NULL

);
GO


GO

