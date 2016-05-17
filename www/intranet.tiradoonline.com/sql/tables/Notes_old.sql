IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Notes_old' AND TYPE = 'U')
DROP TABLE Notes_old;
GO

IF EXISTS (SELECT NAME FROM sysobjects WHERE NAME = 'Notes_old' AND TYPE = 'U')
	DROP TABLE Notes_old;
GO

CREATE TABLE Notes_old
(
	NoteID		IDENTITY (1001,1) INT  NOT NULL,
	UserID		 INT  NOT NULL,
	StartLocation		 INT  NULL,
	Title		 VARCHAR(100)  NULL,
	NoteText		 VARCHAR(MAX)  NULL,
	update_dt		 DATETIME DEFAULT (getdate()) NOT NULL,
	create_dt		 DATETIME DEFAULT (getdate()) NOT NULL

);
GO




GO


GO

