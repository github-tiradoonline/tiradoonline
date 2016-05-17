IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FilteredBrowsers' AND TYPE = 'U')
DROP TABLE FilteredBrowsers;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FilteredBrowsers' AND TYPE = 'U')
	DROP TABLE FilteredBrowsers;
GO

CREATE TABLE FilteredBrowsers
(
	FilteredBrowserID		IDENTITY (1001,1) INT  NOT NULL,
	Alias		 VARCHAR(50)  NOT NULL,
	Browser		 VARCHAR(500)  NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO

GO

