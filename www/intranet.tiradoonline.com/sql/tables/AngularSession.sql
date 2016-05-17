IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'AngularSession' AND TYPE = 'U')
	DROP TABLE AngularSession;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'AngularSession' AND TYPE = 'U')
	DROP TABLE AngularSession;
GO

CREATE TABLE AngularSession
(
	AngularSessionID		INT IDENTITY(1001,1) NOT NULL,
	UserID		 		INT  NOT NULL,
	AngularSessionName 		VARCHAR(100) NOT NULL,
	AngularSessionValue 		VARCHAR(MAX) NOT NULL,
	create_dt 			SMALLDATETIME DEFAULT (getdate()) NOT NULL

);
GO

ALTER TABLE AngularSession ADD CONSTRAINT PK_AngularSession PRIMARY KEY (AngularSessionID);
GO