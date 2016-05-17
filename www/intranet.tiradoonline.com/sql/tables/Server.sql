IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FK_ServerInformation_ServerInformation_ServerInformationID' AND TYPE = 'FK')
	ALTER TABLE ServerInformation DROP CONSTRAINT FK_ServerInformation_ServerInformation_ServerInformationID;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ServerInformation' AND TYPE = 'U')
	DROP TABLE ServerInformation;
GO

CREATE TABLE ServerInformation
(
	ServerInformationID			INT IDENTITY(1001, 1) NOT NULL,
	ServerID				INT NOT NULL,
	ServerInformationOrderNum		TINYINT NOT NULL,
	ServerInformationName		VARCHAR(50) NOT NULL,
	ServerInformationValue		VARCHAR(MAX) NULL,
	create_dt					DATETIME  NOT NULL DEFAULT GETDATE()
);
GO

ALTER TABLE ServerInformation ADD CONSTRAINT PK_ServerInformation_ServerInformationID PRIMARY KEY NONCLUSTERED (ServerInformationID);
GO




IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'FK_Server_ServerProject_ServerProjectID' AND TYPE = 'FK')
	ALTER TABLE Server DROP CONSTRAINT FK_Server_ServerProject_ServerProjectID;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Server' AND TYPE = 'U')
	DROP TABLE Server
GO

CREATE TABLE Server
(
	ServerID					INT IDENTITY(1001, 1) NOT NULL,
	ServerProjectID						INT NOT NULL,
	ServerName					VARCHAR(50) NOT NULL,
	ServerNotes					VARCHAR(MAX) NULL,
	create_dt					DATETIME  NOT NULL DEFAULT GETDATE()
);
GO

ALTER TABLE Server ADD CONSTRAINT PK_Server_ServerID PRIMARY KEY NONCLUSTERED (ServerID);
GO

ALTER TABLE ServerInformation ADD CONSTRAINT FK_ServerInformation_Server_ServerID FOREIGN KEY (ServerID) REFERENCES Server(ServerID);
GO





IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'ServerProject' AND TYPE = 'U')
	DROP TABLE ServerProject
GO

CREATE TABLE ServerProject
(
	ServerProjectID					INT IDENTITY(1001, 1) NOT NULL,
	UserID						INT NOT NULL,
	ServerProjectName				VARCHAR(50) NOT NULL,
	ServerProjectNotes				VARCHAR(MAX) NULL,
	create_dt					DATETIME  NOT NULL DEFAULT GETDATE()
);
GO

ALTER TABLE ServerProject ADD CONSTRAINT PK_ServerProject_ServerProjectID PRIMARY KEY NONCLUSTERED (ServerProjectID);
GO

ALTER TABLE Server ADD CONSTRAINT FK_Server_ServerProject_ServerProjectID FOREIGN KEY (ServerProjectID) REFERENCES ServerProject(ServerProjectID);
GO


ALTER TABLE ServerProject ADD CONSTRAINT FK_ServerProject_Users_UserID FOREIGN KEY (UserID) REFERENCES Users(UserID);
GO



