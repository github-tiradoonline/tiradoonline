IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetGroups' AND TYPE = 'U')
DROP TABLE SnippetGroups;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'SnippetGroups' AND TYPE = 'U')
	DROP TABLE SnippetGroups;
GO

CREATE TABLE SnippetGroups
(
	SnippetGroupID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	SnippetGroupName		 VARCHAR(100)  NOT NULL,
	create_dt		 SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

