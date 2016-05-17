IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Snippets' AND TYPE = 'U')
DROP TABLE Snippets;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Snippets' AND TYPE = 'U')
	DROP TABLE Snippets;
GO

CREATE TABLE Snippets
(
	SnippetID		IDENTITY (1001,1) INT  NOT NULL,
	SnippetGroupID		 INT  NOT NULL,
	SnippetName		 VARCHAR(100)  NOT NULL,
	Snippet		 VARCHAR(MAX)  NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL,
	update_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

